class Admin::DistrictsController < Admin::BaseController
  def districts_by_city
    @districts = District.where(city_id: params[:city_id])
    authorize @districts

    respond_to do |format|
      format.json { render json: @districts }
    end
  end
end
