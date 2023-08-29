class Admin::BusinessAreasController < ApplicationController
  layout 'admin_layout'

  before_action :prepare_business_area, only: %i[edit update destroy]

  def search
    query = params[:q]&.strip&.downcase
    @pagy, @business_areas = pagy_array([])

    @business_areas = BusinessArea.where("business_areas.name LIKE ? ", "%#{query}%") if query.present?

    if @business_areas.blank?
      render 'no_result'
    else
      render 'index'
    end
  end

  def index
    authorize BusinessArea
    @pagy, @business_areas = pagy(BusinessArea.all, items: 15)
  end

  def new
    authorize BusinessArea
    @business_area = BusinessArea.new
  end

  def create
    @business_area = BusinessArea.new(business_area_params)
    authorize @business_area
    if @business_area.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to admin_business_areas_path, notice: 'Business Area was successfully created!' }
        # format.turbo_stream { render turbo_stream: turbo_stream.append("new_business_area", target: "new_business_area", partial: "business_areas/business_area", locals: { business_area: @business_area }) }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @business_area
  end

  def update
    authorize @business_area
    if @business_area.update(business_area_params)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to admin_business_areas_path, notice: 'Business Area was successfully updated!' }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @business_area
    @business_area.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to admin_business_areas_path, notice: 'Business Area was successfully deleted!' }
    end
  end

  def prepare_business_area
    @business_area = BusinessArea.find(params[:id])
  end

  private

  def business_area_params
    params.require(:business_area).permit(:name, :detail)
  end
end
