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
      flash[:notice] = "Create successfully represent..."
      redirect_to new_admin_company_path
    else 
      render :new, status: :unprocessable_entity
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
