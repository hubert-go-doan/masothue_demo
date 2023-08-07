class CitiesController < ApplicationController
  before_action :prepare_cities, only: %i[index show]

  def index
  end

  def show
    @city = City.includes(:districts, :companies).find(params[:id])
    @districts = @city.districts
    @companies = @city.companies.to_a.shuffle
  rescue ActiveRecord::RecordNotFound
    redirect_to cities_path
  end

  def show_district
    @district = District.includes(:city, :wards, :companies).find(params[:id])
    @city = @district.city
    @wards = @district.wards
    @companies = @district.companies.to_a.shuffle
  end

  def show_ward
    @ward = Ward.includes(district: [:city, :wards, :companies]).find(params[:id])
    @city = @ward.district.city
    @district = @ward.district
    @wards = @district.wards
    @companies = @ward.companies.to_a.shuffle
  end

  def prepare_cities
    @cities = City.order(:id)
  end
end
