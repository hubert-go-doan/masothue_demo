class CitiesController < ApplicationController

  before_action :prepare_cities, only: %i[index show]

  def index
  end

  def show
    @city = City.find(params[:id]) 
    @districts = @city.districts
    @companies = @city.companies.shuffle
    rescue ActiveRecord::RecordNotFound 
      redirect_to cities_path   
  end

  def show_district
    @district = District.find(params[:id]) 
    @city = @district.city
    @wards = @district.wards
    @companies = @district.companies.shuffle
  end

  def show_ward
    @ward = Ward.find(params[:id]) 
    @city = @ward.district.city
    @district = @ward.district
    @wards = @district.wards
    @companies = @ward.companies.shuffle
  end

  def prepare_cities
    @cities =  City.order(:id)
  end
end


