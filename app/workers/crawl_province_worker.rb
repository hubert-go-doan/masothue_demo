require 'sidekiq-scheduler'
require 'json'
require 'redis'

class CrawlProvinceWorker
  include Sidekiq::Worker

  def initialize
    @city_data_file = 'cities_data.json'
    @special_province_ids = [29, 24, 15]
    @redis = Redis.new
  end

  def perform
    province_id = next_province_id
    CrawlerCityService.new(@city_data_file).crawl_province_data(province_id)
  end

  private

  def next_province_id
    current_province_id = @redis.get('current_province_id').to_i || 0
    days_since_last_special_province = @redis.get('days_since_last_special_province').to_i || 0

    if days_since_last_special_province >= 3
      days_since_last_special_province = 0
      selected_special_province = @special_province_ids.shift
      @special_province_ids.push(selected_special_province)
      @redis.set('days_since_last_special_province', days_since_last_special_province)
      selected_special_province
    else
      days_since_last_special_province += 1
      current_province_id += 1
      current_province_id = 1 if current_province_id > 63
      @redis.set('current_province_id', current_province_id)
      @redis.set('days_since_last_special_province', days_since_last_special_province)
      current_province_id
    end
  end
end
