class Admin::BusinessAreasController < ApplicationController
  layout 'admin_layout'

  before_action :prepare_business_area, only: %i[edit update destroy]

  def index 
    @pagy, @business_areas = pagy(BusinessArea.all, items: 15)
  end

  def new
    @business_area = BusinessArea.new
  end

  def create
    @business_area = BusinessArea.new(business_area_params)
    if @business_area.save 
      redirect_to admin_business_areas_path, notice: 'Business Area was successfully created!'
    else 
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update  
    if @business_area.update(business_area_params)
      redirect_to admin_business_areas_path, notice: 'Business Area was successfully updated!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @business_area.destroy
    redirect_to admin_business_areas_path, notice: 'Business Area was successfully deleted!'
  end

  def prepare_business_area
    @business_area = BusinessArea.find(params[:id])
  end

  private
    def business_area_params
      params.require(:business_area).permit(:name, :detail)
    end
end
