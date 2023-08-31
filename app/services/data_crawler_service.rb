require 'nokogiri'
require 'open-uri'

class DataCrawlerService
  BASE_URL = 'https://masothue.com'.freeze

  def call
    crawl_and_save_provinces
  end

  private

  def crawl_and_save_provinces
    page = Nokogiri::HTML(URI.open(BASE_URL))
    cities_list = page.css('aside ul.row')
    cities_list.css('li.cat-item').each do |li|
      province_name = li.css('a').text
      province_url = "#{BASE_URL}#{li.css('a').attr('href').value}"
      province = City.find_or_create_by(name: province_name)
      crawl_and_save_districts(province, province_url)
    end
  end

  def crawl_and_save_districts(province, province_url)
    page = Nokogiri::HTML(URI.open(province_url))
    district_list = page.css('ul.row')
    district_list.css('li.cat-item').each do |li|
      district_name = li.css('a').text
      district_url = "#{BASE_URL}#{li.css('a').attr('href').value}"
      district = District.find_or_create_by(name: district_name, city_id: province.id)
      crawl_and_save_wards(district, district_url)
    end
  end

  def crawl_and_save_wards(district, district_url)
    page = Nokogiri::HTML(URI.open(district_url))
    ward_list = page.css('ul.row')
    ward_list.css('li.cat-item').each do |li|
      ward_name = li.css('a').text
      ward_url = "#{BASE_URL}#{li.css('a').attr('href').value}"
      ward = Ward.find_or_create_by(name: ward_name, district_id: district.id)
      crawl_and_save_companies_in_ward(ward, ward_url, district)
    end
  end

  def crawl_and_save_companies_in_ward(ward, ward_url, district)
    page = Nokogiri::HTML(URI.open(ward_url))
    company_list = page.css('.tax-listing')
    count = 0
    company_list.css('div[data-prefetch]').each do |div|
      break if count >= 2

      h3 = div.css('h3 a')
      company_name = h3.text
      company_url = "#{BASE_URL}#{h3.attr('href').value}"
      represent_name = div.css('div em a').text

      begin
        if company_name == represent_name
          crawl_and_save_person(company_url, ward.district.city, ward.district, ward)
        else
          crawl_and_save_company(company_url, ward.district.city, ward.district, ward)
        end
      rescue OpenURI::HTTPError => e
        next unless e.message.include?('403 Forbidden')

        sleep(10)
        retry
      end
      count += 1
    end
  end

  def crawl_and_save_company(company_url, city, district, ward)
    page = Nokogiri::HTML(URI.open(company_url))
    puts company_url

    representative_name = page.css('tr[itemprop="alumni"] span[itemprop="name"] a').text
    represent = Represent.find_or_create_by(name: representative_name)

    business_area_name_element = page.css('td strong a').last
    business_area_name = business_area_name_element&.text || ""
    business_area = BusinessArea.find_or_create_by(name: business_area_name)

    name = page.css('table.table-taxinfo th[itemprop="name"] .copy').text
    sub_name = page.css('td:contains("Tên viết tắt")').first
    sub_name = sub_name ? sub_name.next_element.text.strip : ""

    company_type_name_element = page.css('td:contains("Loại hình DN")').first
    company_type_name = company_type_name_element&.next_element&.text || "Chưa cập nhật loại hình DN..."
    company_type = CompanyType.find_or_create_by(type_name: company_type_name)

    status_element = page.css('td:contains("Tình trạng")').first&.next_element
    status_name = status_element&.text || ''
    status = Status.find_or_create_by(name: status_name)

    phone_number_element = page.css('.table-taxinfo td[itemprop="telephone"] span.copy')
    phone_number = phone_number_element&.text || ''

    managed_by_element = page.css('td:contains("Quản lý bởi")').first
    managed_by = managed_by_element&.next_element&.text || ''

    date_start_element = page.css('td:contains("Ngày hoạt động")').first
    date_start = date_start_element&.next_element&.text || ''

    address = page.css('.table-taxinfo td[itemprop="address"] span.copy').text

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
    tax_code.update(taxable: company)
  end

  def crawl_and_save_person(company_url, city, district, ward)
    page = Nokogiri::HTML(URI.open(company_url))
    puts "#{company_url}"

    company_type_name_element = page.css('td:contains("Loại hình DN")').first
    company_type_name = company_type_name_element&.next_element&.text || "Chưa cập nhật loại hình DN..."
    company_type = CompanyType.find_or_create_by(type_name: company_type_name)

    name = page.css('table.table-taxinfo th[itemprop="name"] .copy').text

    status_element = page.css('td:contains("Tình trạng")').first&.next_element
    status_name = status_element&.text || ''
    status = Status.find_or_create_by(name: status_name)

    phone_number_element = page.css('.table-taxinfo td[itemprop="telephone"] span.copy')
    phone_number = phone_number_element&.text || ''

    managed_by = page.css('td:contains("Quản lý bởi")').first
    managed_by = managed_by&.next_element&.text || ''

    date_start_element = page.css('td:contains("Ngày hoạt động")').first
    date_start = date_start_element&.next_element&.text || ''

    address = page.css('.table-taxinfo td[itemprop="address"] span.copy').text

    tax_code_text_element = page.css('.table-taxinfo td[itemprop="taxID"] span.copy').first
    tax_code_text = tax_code_text_element&.text || ''
    tax_code = TaxCode.find_or_create_by(code: tax_code_text)

    person = Person.create(
      name:,
      phone_number:,
      date_start:,
      managed_by:,
      address:,
      city:,
      district:,
      ward:,
      company_type:,
      status:
    )
    tax_code.update(taxable: person)
  end
end
