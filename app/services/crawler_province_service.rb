require 'nokogiri'
require 'open-uri'
require 'faraday'
require 'json'

class CrawlerProvinceService
  BASE_URL = ENV['BASE_URL'].freeze
  PROXY_LIST = ENV['PROXY_LIST'].split(',')

  DEFAULT_MAX_PROXY_REQUESTS = 50

  def initialize
    @city_data = []
    @proxy_index = 0
    @requests_count = 0
  end

  def call
    crawl_and_save_provinces
  end

  private

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

  def save_to_json(data)
    File.open('cities_data.json', 'w') { |file| file.write(JSON.generate(data)) }
  end

  def crawl_and_save_provinces
    page = Nokogiri::HTML(fetch_url_with_proxy(BASE_URL))
    cities_list = page.css('aside ul.row')
    cities_list.css('li.cat-item').each do |li|
      province_name = li.css('a').text
      province_url = "#{BASE_URL}#{li.css('a').attr('href').value}"
      province = City.find_or_create_by(name: province_name)
      @city_data << { name: province_name, url: province_url, id: province.id }

      p @city_data
    end
    save_to_json(@city_data)
  end

  def retry_url_with_new_ip(url)
    @proxy_index = (@proxy_index + 1) % PROXY_LIST.length
    fetch_url_with_proxy(url)
  end
end
