require 'sidekiq-scheduler'
require 'json'

class CrawlProvinceWorker
  include Sidekiq::Worker

  HCM_ID = 29
  HANOI_ID = 24
  DANANG_ID = 15
  BINHDUONG_ID = 9

  SPECIAL_PROVINCE_IDS = [HCM_ID, HANOI_ID, DANANG_ID, BINHDUONG_ID].freeze

  def perform
    province_id = next_province_id_to_crawl
    CrawlerCityService.new('cities_data.json').crawl_province_data(province_id)
    City.find(province_id).update(updated_at: Time.current)
  end

  private

  def next_province_id_to_crawl
    current_day = Time.zone.today.day

    if (current_day % 3).zero?
      SPECIAL_PROVINCE_IDS.min_by { |province_id| City.find(province_id).updated_at }
    else
      City.order(updated_at: :asc).first.id
    end
  end
end
