require 'nokogiri'
require 'open-uri'
require 'faraday'
require 'pstore'

class DataCrawlerService
  BASE_URL = 'https://masothue.com'.freeze
  PROXY_LIST = [
    'http://38.62.222.142:3128',
    'http://154.6.96.143:3128',
    'http://154.6.99.36:3128',
    'http://154.6.96.19:3128',
    'http://154.6.98.219:3128',
    'http://38.62.223.86:3128',
    'http://154.6.98.178:3128',
    'http://38.62.221.185:3128',
    'http://154.6.96.133:3128',
    'http://38.62.221.164:3128',
    'http://154.6.96.159:3128',
    'http://38.62.220.45:3128',
    'http://154.6.97.74:3128',
    'http://38.62.222.115:3128',
    'http://154.6.96.244:3128',
    'http://38.62.223.222:3128',
    'http://38.62.222.55:3128',
    'http://154.6.97.29:3128',
    'http://38.62.221.9:3128',
    'http://38.62.222.183:3128',
    'http://38.62.222.82:3128',
    'http://38.62.223.88:3128',
    'http://38.62.222.191:3128',
    'http://38.62.222.144:3128',
    'http://154.6.99.174:3128',
    'http://154.6.97.89:3128',
    'http://154.6.98.247:3128',
    'http://38.62.220.164:3128',
    'http://38.62.221.35:3128',
    'http://154.6.96.8:3128',
    'http://154.6.96.80:3128',
    'http://154.6.96.41:3128',
    'http://38.62.220.170:3128',
    'http://38.62.223.195:3128',
    'http://154.6.98.243:3128',
    'http://154.6.98.203:3128',
    'http://154.6.99.110:3128',
    'http://38.62.220.190:3128',
    'http://38.62.223.24:3128',
    'http://154.6.98.138:3128',
    'http://38.62.222.123:3128',
    'http://38.62.222.193:3128',
    'http://154.6.99.64:3128',
    'http://38.62.223.193:3128',
    'http://154.6.97.69:3128',
    'http://38.62.222.125:3128',
    'http://154.6.97.22:3128',
    'http://154.6.96.253:3128',
    'http://38.62.223.128:3128',
    'http://154.6.99.95:3128',
    'http://38.62.222.163:3128',
    'http://38.62.223.235:3128',
    'http://38.62.222.173:3128',
    'http://38.62.221.33:3128',
    'http://154.6.96.112:3128',
    'http://154.6.99.2:3128',
    'http://38.62.220.149:3128',
    'http://154.6.97.123:3128',
    'http://38.62.221.158:3128',
    'http://154.6.99.62:3128',
    'http://154.6.99.159:3128',
    'http://38.62.223.204:3128',
    'http://154.6.98.150:3128',
    'http://38.62.222.236:3128',
    'http://154.6.98.121:3128',
    'http://154.6.97.168:3128',
    'http://38.62.220.84:3128',
    'http://38.62.220.103:3128',
    'http://38.62.221.84:3128',
    'http://154.6.98.70:3128',
    'http://154.6.97.126:3128',
    'http://38.62.223.48:3128',
    'http://154.6.96.5:3128',
    'http://154.6.96.199:3128',
    'http://154.6.99.22:3128',
    'http://38.62.223.251:3128',
    'http://38.62.223.170:3128',
    'http://38.62.223.248:3128',
    'http://38.62.221.191:3128',
    'http://38.62.222.212:3128',
    'http://38.62.223.33:3128',
    'http://154.6.96.247:3128',
    'http://38.62.221.43:3128',
    'http://38.62.222.1:3128',
    'http://154.6.98.114:3128',
    'http://154.6.97.188:3128',
    'http://38.62.220.83:3128',
    'http://38.62.220.208:3128',
    'http://38.62.223.136:3128',
    'http://154.6.96.135:3128',
    'http://154.6.98.101:3128',
    'http://38.62.223.120:3128',
    'http://154.6.96.242:3128',
    'http://38.62.221.59:3128',
    'http://154.6.97.220:3128',
    'http://38.62.221.175:3128',
    'http://38.62.220.107:3128',
    'http://38.62.223.58:3128',
    'http://38.62.220.248:3128',
    'http://154.6.96.24:3128'
  ]

  def initialize
    @province_data = PStore.new('province_data.pstore')
    @proxy_index = 0
    @requests_count = 0
    @proxy_retry_count = 0
  end

  def call
    crawl_and_save_provinces
  end

  def crawl_province_data(province_id)
    province_data = @province_data.transaction { @province_data[province_id] }
    return unless province_data

    crawl_and_save_districts(province_data[:id], province_data[:url])
  end

  private

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
    if @requests_count >= 30
      rotate_proxy
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

  def crawl_and_save_provinces
    page = Nokogiri::HTML(fetch_url_with_proxy(BASE_URL))
    cities_list = page.css('aside ul.row')
    cities_list.css('li.cat-item').each do |li|
      province_name = li.css('a').text
      province_url = "#{BASE_URL}#{li.css('a').attr('href').value}"
      province = City.find_or_create_by(name: province_name)
      province_data = { name: province_name, url: province_url, id: province.id }

      @province_data.transaction { @province_data[province.id] = province_data }
      p @province_data
    end
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

      if page_number == 1
        first_url_in_ward = first_url_on_page
      end

      if page_number > 1 && first_url_on_page == first_url_in_ward
        puts "All pages have been crawled for ward #{ward.name}. Moving to the next ward..."
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
    if @proxy_retry_count < 20
      @proxy_retry_count += 1
      rotate_proxy
      puts "Switching to proxy: #{PROXY_LIST[@proxy_index]} (Retry #{@proxy_retry_count})"
      fetch_url_with_proxy(url)
    else
      @proxy_retry_count = 0
      nil
    end
  end

  def crawl_and_save_company(company_url, city, district, ward)
    default_date_start = Date.new(2000, 1, 1)
    page = Nokogiri::HTML(fetch_url_with_proxy(company_url))
    puts company_url

    representative_name = page.css('tr[itemprop="alumni"] span[itemprop="name"] a').text || 'Chưa update'
    represent = Represent.find_or_create_by(name: representative_name)

    business_area_name_element = page.css('td strong a').last
    business_area_name = business_area_name_element&.text || ''
    business_area = BusinessArea.find_or_create_by(name: business_area_name)

    name = page.css('table.table-taxinfo th[itemprop="name"] .copy').text
    sub_name = page.css('td:contains("Tên viết tắt")').first
    sub_name = sub_name ? sub_name.next_element.text.strip : ''

    company_type_name_element = page.css('td:contains("Loại hình DN")').first
    company_type_name = company_type_name_element&.next_element&.text || 'Chưa update'
    company_type = CompanyType.find_or_create_by(type_name: company_type_name)

    status_element = page.css('td:contains("Tình trạng")').first
    status_name = status_element&.next_element&.text || 'Chưa update'
    status = Status.find_or_create_by(name: status_name)

    phone_number_element = page.css('.table-taxinfo td[itemprop="telephone"] span.copy')
    phone_number_text = phone_number_element&.text
    if phone_number_text.nil? || phone_number_text.empty?
      phone_number = 0
    else
      phone_number = phone_number_text.to_i
    end

    managed_by_element = page.css('td:contains("Quản lý bởi")').first
    managed_by = managed_by_element ? managed_by_element.next_element.text : 'Chưa update'

    date_start_element = page.css('td:contains("Ngày hoạt động")').first
    date_start = date_start_element ? date_start_element.next_element.text : default_date_start

    address = page.css('.table-taxinfo td[itemprop="address"] span.copy').text.presence || 'Chưa update'

    tax_code_text_element = page.css('.table-taxinfo td[itemprop="taxID"] span.copy').first
    tax_code_text = tax_code_text_element&.text || ''
    tax_code = TaxCode.find_or_create_by(code: tax_code_text)

    company = Company.create(
      name:,
      sub_name:,
      date_start:,
      phone_number:,
      managed_by:,
      address:,
      city:,
      district:,
      ward:,
      company_type:,
      business_area:,
      status:,
      represent:
    )
    puts company.errors.full_messages
    tax_code.update(taxable: company)
  end

  def crawl_and_save_person(company_url, city, district, ward)
    default_date_start = Date.new(2000, 1, 1)

    page = Nokogiri::HTML(fetch_url_with_proxy(company_url))
    puts "PERSON_URL: #{company_url}"

    name = page.css('table.table-taxinfo th[itemprop="name"] .copy').text
    company_type_name_element = page.css('td:contains("Loại hình DN")').first
    company_type_name = company_type_name_element&.next_element&.text || 'Chưa update'
    company_type = CompanyType.find_or_create_by(type_name: company_type_name)
    status_element = page.css('td:contains("Tình trạng")').first&.next_element
    status_name = status_element&.text || 'Chưa update'
    status = Status.find_or_create_by(name: status_name)

    phone_number_element = page.css('.table-taxinfo td[itemprop="telephone"] span.copy')
    phone_number_text = phone_number_element&.text
    if phone_number_text.nil? || phone_number_text.empty?
      phone_number = 0
    else
      phone_number = phone_number_text.to_i
    end

    managed_by_element = page.css('td:contains("Quản lý bởi")').first
    managed_by = managed_by_element ? managed_by_element.next_element.text : 'Chưa update'

    date_start_element = page.css('td:contains("Ngày hoạt động")').first
    date_start = date_start_element ? date_start_element.next_element.text : default_date_start

    address = page.css('.table-taxinfo td[itemprop="address"] span.copy').text.presence || 'Chưa update'

    tax_code_text_element = page.css('.table-taxinfo td[itemprop="taxID"] span.copy').first
    tax_code_text = tax_code_text_element&.text || ''
    tax_code = TaxCode.find_or_create_by(code: tax_code_text)

    person = Person.create(
      name:,
      date_start:,
      phone_number:,
      managed_by:,
      address:,
      city:,
      district:,
      ward:,
      company_type:,
      status:
    )
    puts person.errors.full_messages
    tax_code.update(taxable: person)
  end
end
