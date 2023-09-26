require 'sidekiq-scheduler'

class CrawlProvinceMonthlyWorker
  include Sidekiq::Worker

  def perform
    CrawlerProvinceService.new.call
  end
end
