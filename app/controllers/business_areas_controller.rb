class BusinessAreasController < ApplicationController

  before_action :prepare_cities, only: %i[index show]

  def index
    @business_areas = BusinessArea.all
    prepare_breadcrumb_data
  end

  def show
    @business_area = BusinessArea.find_by(id:params[:id])
    redirect_to business_areas_path if @business_area.nil?
    @data = @business_area.companies.shuffle

    prepare_breadcrumb_data unless @business_area.nil?
  end

  private
    def prepare_cities
      @cities =  City.order(:id)
    end


  def prepare_breadcrumb_data
    @breadcrumb_data = [
      { name: 'Tra cứu mã số thuế', path: root_path },
      { name: 'Ngành nghề', path: business_areas_path }
    ]
    @breadcrumb_data << { name: @business_area.name, path: business_area_path(@business_area) } if action_name == 'show'
  end
end
