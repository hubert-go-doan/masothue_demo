class Admin::RepresentsController < ApplicationController
  layout 'admin_layout'

  def new
    authorize Represent
    @represent = Represent.new
  end

  def create
    @represent = Represent.new(represent_params)
    authorize @represent
    if @represent.save
      respond_to do |format|
        format.html { redirect_to new_admin_company_path, notice: 'Create successfully represent' }
        format.turbo_stream { flash.now[:notice] = "Create successfully represent" }
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def represent_params
    params.require(:represent).permit(
      :name,
      :day_of_birth
    )
  end
end
