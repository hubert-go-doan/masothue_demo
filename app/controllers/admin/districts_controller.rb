class Admin::DistrictsController < ApplicationController
  def districts_by_city
    @districts = District.where(city_id: params[:city_id])
    respond_to do |format|
      format.json { render json: @districts }
    end
  end
end
