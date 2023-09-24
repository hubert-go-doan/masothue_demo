require 'sidekiq-scheduler'

class CrawlProvinceWorker
  include Sidekiq::Worker

  def perform
    current_id = Rails.application.config.crawl_province_current_id
    CrawlerCityService.new('cities_data.json').crawl_province_data(current_id)

    Rails.application.config.crawl_province_current_id = (current_id % 63) + 1
  end
end
