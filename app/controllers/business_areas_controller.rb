class BusinessAreasController < ApplicationController

  before_action :prepare_cities, only: %i[index show]

  def index
    @business_areas = BusinessArea.all
  end

  def show
    @business_area = BusinessArea.find(params[:id]) 
    @data = @business_area.companies.shuffle
    rescue ActiveRecord::RecordNotFound 
      redirect_to business_areas_path   
  end

  private
    def prepare_cities
      @cities =  City.order(:id)
    end
end
