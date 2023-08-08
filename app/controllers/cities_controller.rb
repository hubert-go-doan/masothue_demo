class CitiesController < ApplicationController
  before_action :prepare_cities, only: %i[index show]

  def index
    prepare_breadcrumb([{ name: 'Tỉnh thành phố', path: cities_path }])
  end

  def show
    @city = City.includes(:districts, :companies).find(params[:id])
    prepare_breadcrumb([
      { name: 'Tỉnh thành phố', path: cities_path },
      { name: @city.name, path: city_path(@city) }
    ])
    @districts = @city.districts
    @companies = @city.companies.to_a.shuffle
    rescue ActiveRecord::RecordNotFound
      redirect_to cities_path
  end

  def show_district
    @district = District.includes(:city, :wards, :companies).find(params[:id])
    @city = @district.city
    prepare_breadcrumb([
      { name: 'Tỉnh thành phố', path: cities_path },
      { name: @city.name, path: city_path(@city) },
      { name: @district.name, path: district_path(@district) }
    ])
    @wards = @district.wards
    @companies = @district.companies.to_a.shuffle
  end

  def show_ward
    @ward = Ward.includes(district: [:city, :wards, :companies]).find(params[:id])
    @city = @ward.district.city
    @district = @ward.district
    prepare_breadcrumb([
      { name: 'Tỉnh thành phố', path: cities_path },
      { name: @city.name, path: city_path(@city) },
      { name: @district.name, path: district_path(@district) },
      { name: @ward.name, path: ward_path(@ward) }
    ])
    @wards = @district.wards
    @companies = @ward.companies.to_a.shuffle
  end
  
  private

  def prepare_cities
    @cities = City.order(:id)
  end

  def prepare_breadcrumb(items)
    @breadcrumb_data = [
      { name: 'Tra cứu mã số thuế', path: root_path }
    ]
    @breadcrumb_data.concat(items)
  end
end