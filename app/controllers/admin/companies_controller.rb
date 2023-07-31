class Admin::CompaniesController < ApplicationController
  layout 'admin_layout'

  before_action :prepare_data, only: [:new, :create, :edit]
  before_action :prepare_company, only: [:edit, :update, :destroy]

  def index 
    @companies = Company.all
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    if @company.save 
      redirect_to admin_companies_path
    else 
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @company.update(company_params)
      redirect_to admin_companies_path 
    else
      render :edit, status: :unprocessable_entity   
    end 
  end

  def destroy
    # @company = Company.find(params[:id])
    @company.destroy
    redirect_to admin_companies_path, status: :see_other
  end

  def prepare_data
    @city_list = City.all.map { |city| [city.name, city.id] }
    @represent_list = Represent.all.map { |repre| [repre.name, repre.id] }
    @company_type_list = CompanyType.all.map { |com_type| [com_type.type_name, com_type.id] }
    @status_list = Status.all.map { |status| [status.name, status.id] }
    @business_area_list = BusinessArea.all.map { |business| [business.name, business.id] }
  end

  def prepare_company
    @company = Company.find(params[:id])
  end

  private
    def company_params
      params.require(:company).permit(
        :name, 
        :sub_name, 
        :address, 
        :date_start, 
        :phone_number, 
        :managed_by,
        :city_id, 
        :district_id, 
        :ward_id, 
        :company_type_id, 
        :business_area_id,
        :represent_id, 
        :status_id
      )
    end
end
