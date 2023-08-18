class Admin::CompaniesController < ApplicationController
  layout 'admin_layout'

  before_action :prepare_data, only: %i[new create edit]
  before_action :prepare_company, only: %i[edit update destroy]
  before_action :prepare_data_filter, only: %i[index search]

  def search
    query = params[:q]&.strip&.downcase

    @companies = []

    @companies = Company.where("LOWER(companies.name) LIKE ? OR LOWER(represents.name) LIKE ? OR tax_codes.code LIKE ?", "%#{query}%", "%#{query}%", "%#{query}%").joins(:represent, :tax_code).includes(:tax_code, :represent, :business_area, :status, :company_type) if query.present?

    @pagy, @companies = pagy_array(@companies, items: 10)

    if @companies.blank?
      render 'no_result'
    else
      render 'index'
    end
  end

  def index
    authorize Company

    companies = Company.includes(:tax_code, :represent, :status, :business_area, :company_type).all

    companies = companies.where(city_id: params[:city_id]) if params[:city_id].present?

    companies = companies.where(status_id: params[:status_id]) if params[:status_id].present?

    @pagy, @companies = pagy(companies, items: 10)
  end

  def new
    authorize Company
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    authorize @company
    if @company.save
      redirect_to admin_companies_path, notice: 'Company was successfully created!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @company
  end

  def update
    authorize @company
    if @company.update(company_params)
      redirect_to admin_companies_path, notice: 'Company was successfully updated!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @company
    @company.destroy
    redirect_to admin_companies_path, status: :see_other, notice: 'Company was successfully deleted!'
  end

  def prepare_data
    @city_list = City.pluck(:name, :id)
    @represent_list = Represent.pluck(:name, :id)
    @company_type_list = CompanyType.pluck(:type_name, :id)
    @status_list = Status.pluck(:name, :id)
    @business_area_list = BusinessArea.pluck(:name, :id)
  end

  def prepare_company
    @company = Company.find(params[:id])
  end

  def prepare_data_filter
    @cities = City.order(:id)
    @status_list = Status.pluck(:name, :id)
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
