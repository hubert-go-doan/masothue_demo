require 'nokogiri'
require 'open-uri'
require 'faraday'
require 'json'

class CrawlerCityService
  BASE_URL = ENV['BASE_URL'].freeze
  PROXY_LIST = ENV['PROXY_LIST'].split(',')

  DEFAULT_NOT_UPDATED = 'Chưa update'.freeze
  DEFAULT_EMPTY_STRING = ''.freeze
  DEFAULT_DATE_START = Date.new(2000, 1, 1)
  DEFAULT_MAX_PROXY_RETRYS = 30
  DEFAULT_MAX_PROXY_REQUESTS = 50

  def initialize(city_data_file)
    @city_data_file = city_data_file
    @city_data = load_city_data
    @proxy_index = 0
    @requests_count = 0
    @proxy_retry_count = 0
  end

  def call(province_id)
    crawl_province_data(province_id)
  end

  private

  def crawl_province_data(province_id)
    province_data = @city_data.find { |province| province['id'] == province_id }
    return unless province_data

    province_id = province_data['id']
    province_url = province_data['url']

    crawl_and_save_districts(province_id, province_url)
  end

  def load_city_data
    JSON.parse(File.read(@city_data_file))
  end

  def url_accessible?(url)
    proxy = PROXY_LIST[@proxy_index]
    conn = Faraday.new(url:, proxy:)

    begin
      response = conn.head
      response.status == 200
    rescue Faraday::ConnectionFailed
      false
    end
  end

  def fetch_url_with_proxy(url)
    if @requests_count >= DEFAULT_MAX_PROXY_REQUESTS
      rotate_proxy
      puts "Switching to proxy: #{PROXY_LIST[@proxy_index]}"
      @requests_count = 0
    end

    proxy = PROXY_LIST[@proxy_index]
    conn = Faraday.new(url:, proxy:)
    begin
      response = conn.get
      case response.status
      when 200
        @requests_count += 1
        @proxy_retry_count = 0
        response.body
      when 403
        puts "403 Forbidden: #{url}"
        retry_url_with_new_ip(url)
      when 404
        puts "404 Not Found: #{url}"
        nil
      else
        raise "Failed to fetch #{url}, HTTP status code: #{response.status}"
      end
    rescue Exception => e
      puts "An error occurred: #{e.message}"
      retry_url_with_new_ip(url)
    end
  end

  def rotate_proxy
    @proxy_index = (@proxy_index + 1) % PROXY_LIST.length
  end

  def crawl_and_save_districts(province_id, province_url)
    page = Nokogiri::HTML(fetch_url_with_proxy(province_url))
    district_list = page.css('ul.row')
    district_list.css('li.cat-item').each do |li|
      district_name = li.css('a').text
      puts district_name
      district_url = "#{BASE_URL}#{li.css('a').attr('href').value}"
      district = District.find_or_create_by(name: district_name, city_id: province_id)
      crawl_and_save_wards(district, district_url)
    end
  end

  def crawl_and_save_wards(district, district_url)
    page = Nokogiri::HTML(fetch_url_with_proxy(district_url))
    ward_list = page.css('ul.row')
    ward_list.css('li.cat-item').each do |li|
      ward_name = li.css('a').text
      puts ward_name
      ward_url = "#{BASE_URL}#{li.css('a').attr('href').value}"
      ward = Ward.find_or_create_by(name: ward_name, district_id: district.id)
      crawl_and_save_companies_in_ward(ward, ward_url, district)
    end
  end

  def crawl_and_save_companies_in_ward(ward, ward_url, district)
    first_url_in_ward = nil
    page_number = 1

    loop do
      page_url = "#{ward_url}?page=#{page_number}"
      page = Nokogiri::HTML(fetch_url_with_proxy(page_url))
      puts "Switching to page #{page_number}"
      company_list = page.css('.tax-listing')
      url_exist = company_list.css('div[data-prefetch]')
      break if url_exist.empty?

      first_url_on_page = "#{BASE_URL}#{company_list.css('div[data-prefetch] h3 a').first&.attr('href')}"

      first_url_in_ward = first_url_on_page if page_number == 1

      if page_number > 1 && first_url_on_page == first_url_in_ward
        break
      end

      company_list.css('div[data-prefetch]').each do |div|
        h3 = div.css('h3 a')
        company_name = h3.text
        company_url = "#{BASE_URL}#{h3.attr('href').value}"
        represent_name = div.css('div em a').text

        retry_count = 0
        while retry_count < 5
          if url_accessible?(company_url)
            if company_name == represent_name
              crawl_and_save_person(company_url, ward.district.city, ward.district, ward)
            else
              crawl_and_save_company(company_url, ward.district.city, ward.district, ward)
            end
            break
          else
            retry_count += 1
            if retry_count == 5
              puts "Skipping: #{company_url}"
            else
              puts "Retry #{retry_count} for #{company_url}"
              rotate_proxy
            end
          end
        end
      end
      page_number += 1
    end
  end

  def retry_url_with_new_ip(url)
    if @proxy_retry_count < DEFAULT_MAX_PROXY_RETRYS
      @proxy_retry_count += 1
      rotate_proxy
      puts "Switching to proxy: #{PROXY_LIST[@proxy_index]} (Retry #{@proxy_retry_count})"
      fetch_url_with_proxy(url)
    else
      @proxy_retry_count = 0
      nil
    end
  end

  def crawl_and_save_common_data(page)
    name = page.css('table.table-taxinfo th[itemprop="name"] .copy').text

    company_type_name_element = page.css('td:contains("Loại hình DN")').first
    company_type_name = company_type_name_element&.next_element&.text || DEFAULT_NOT_UPDATED
    company_type = CompanyType.find_or_create_by(type_name: company_type_name)

    status_element = page.css('td:contains("Tình trạng")').first&.next_element
    status_name = status_element&.text || DEFAULT_NOT_UPDATED
    status = Status.find_or_create_by(name: status_name)

    phone_number_element = page.css('.table-taxinfo td[itemprop="telephone"] span.copy')
    phone_number = phone_number_element&.text || DEFAULT_EMPTY_STRING

    managed_by_element = page.css('td:contains("Quản lý bởi")').first
    managed_by = managed_by_element ? managed_by_element.next_element.text : DEFAULT_NOT_UPDATED

    date_start_element = page.css('td:contains("Ngày hoạt động")').first
    date_start = date_start_element ? date_start_element.next_element.text : DEFAULT_DATE_START

    address = page.css('.table-taxinfo td[itemprop="address"] span.copy').text.presence || DEFAULT_NOT_UPDATED

    {
      name:,
      date_start:,
      phone_number:,
      managed_by:,
      address:,
      company_type:,
      status:
    }
  end

  def crawl_and_save_company(company_url, city, district, ward)
    page = Nokogiri::HTML(fetch_url_with_proxy(company_url))
    puts company_url

    representative_name = page.css('tr[itemprop="alumni"] span[itemprop="name"] a').text || DEFAULT_NOT_UPDATED
    represent = Represent.find_or_create_by(name: representative_name)

    business_area_name_element = page.css('td strong a').last
    business_area_name = business_area_name_element&.text || DEFAULT_EMPTY_STRING
    business_area = BusinessArea.find_or_create_by(name: business_area_name)

    sub_name = page.css('td:contains("Tên viết tắt")').first
    sub_name = sub_name ? sub_name.next_element.text.strip : DEFAULT_EMPTY_STRING

    common_data = crawl_and_save_common_data(page)

    tax_code_text_element = page.css('.table-taxinfo td[itemprop="taxID"] span.copy').first
    tax_code_text = tax_code_text_element&.text || DEFAULT_EMPTY_STRING
    existing_tax_code = TaxCode.find_by(code: tax_code_text)

    if existing_tax_code
      company = existing_tax_code.taxable
      company.update(
        common_data.merge(
          {
            sub_name:,
            city:,
            district:,
            ward:,
            represent:,
            business_area:,
            updated_at: Time.current
          }
        )
      )
    else
      company = Company.create(
        common_data.merge(
          {
            sub_name:,
            city:,
            district:,
            ward:,
            represent:,
            business_area:
          }
        )
      )
      TaxCode.create(code: tax_code_text, taxable: company)
    end
  end

  def crawl_and_save_person(company_url, city, district, ward)
    page = Nokogiri::HTML(fetch_url_with_proxy(company_url))
    puts "PERSON_URL: #{company_url}"

    common_data = crawl_and_save_common_data(page)

    tax_code_text_element = page.css('.table-taxinfo td[itemprop="taxID"] span.copy').first
    tax_code_text = tax_code_text_element&.text || DEFAULT_EMPTY_STRING
    existing_tax_code = TaxCode.find_by(code: tax_code_text)

    if existing_tax_code
      person = existing_tax_code.taxable
      person.update(
        common_data.merge(
          {
            city:,
            district:,
            ward:,
            updated_at: Time.current
          }
        )
      )
    else
      person = Person.create(
        common_data.merge(
          {
            city:,
            district:,
            ward:
          }
        )
      )
      TaxCode.create(code: tax_code_text, taxable: person)
    end
  end
end
