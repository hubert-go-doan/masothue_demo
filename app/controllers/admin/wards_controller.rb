class Admin::WardsController < Admin::BaseController
  def wards_by_district
    wards = Ward.where(district_id: params[:district_id])
    authorize wards

    respond_to do |format|
      format.json { render json: wards }
    end
  end
end
