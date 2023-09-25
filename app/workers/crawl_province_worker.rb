require 'sidekiq-scheduler'

class CrawlProvinceWorker
  include Sidekiq::Worker

  def perform
    province_crawler = ProvinceCrawler.new
    current_province_id = province_crawler.next_province_id
    CrawlerCityService.new('cities_data.json').crawl_province_data(current_province_id)
  end
end

class ProvinceCrawler
  attr_reader :current_province_id

  def initialize
    @current_province_id = 0
    @special_province_ids = [29, 24, 15]
    @days_since_last_special_province = 0
  end

  def next_province_id
    if @days_since_last_special_province >= 3
      @days_since_last_special_province = 0
      selected_special_province = @special_province_ids.shift
      @special_province_ids.push(selected_special_province)
      selected_special_province
    else
      @days_since_last_special_province += 1
      @current_province_id += 1
      @current_province_id = 1 if @current_province_id > 63
      @current_province_id
    end
  end
end
