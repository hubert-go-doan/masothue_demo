class NewlyEstablishedController < ApplicationController
  def index
    @cities =  City.order(:id)
    @new_companies = Company.where("date_start >= ?", 20.days.ago).order(date_start: :desc)
  end
end
