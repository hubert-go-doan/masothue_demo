class Admin::CompaniesController < Admin::BaseController
  before_action :prepare_data, only: %i[new create edit update]
  before_action :prepare_company, only: %i[edit update destroy show]
  before_action :prepare_data_filter, only: %i[index search]

  def search
    authorize Company
    query = params[:q]&.strip&.downcase
    @companies = []

    if query.present?
      @companies = Company
        .left_joins(:tax_code, :represent)
        .includes(:tax_code, :represent, :city, :district, :ward)
        .where("LOWER(companies.name) LIKE ? OR LOWER(represents.name) LIKE ? OR COALESCE(tax_codes.code, '') LIKE ?", "%#{query}%", "%#{query}%", "%#{query}%")
    end

    @pagy, @companies = pagy_array(@companies, items: 10)

    if @companies.blank?
      render 'no_result'
    else
      render 'index'
    end
  end

  def index
    authorize Company
    companies = Company.includes(:tax_code, :represent, :city, :district, :ward).all
    companies = companies.where(city_id: params[:city_id]) if params[:city_id].present?
    companies = companies.where(status_id: params[:status_id]) if params[:status_id].present?
    @companies = companies.order(created_at: :asc)
    @pagy, @companies = pagy(@companies, items: 10)
  end

  def show
    authorize Company
    redirect_to admin_company_path if @company.nil?
  end

  def new
    authorize Company
    @company = Company.new
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          dom_id(@company), partial: 'form', locals: { company: @company }
        )
      end
      format.html
    end
  end

  def create
    @company = Company.new(company_params)
    authorize @company
    if @company.save
      respond_to do |format|
        format.html { redirect_to admin_companies_path, notice: 'Company was successfully created!' }
        format.turbo_stream { flash.now[:notice] = 'Company was successfully created!' }
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
    authorize @company
  end

  def update
    authorize @company
    if @company.update(company_params)
      respond_to do |format|
        format.html { redirect_to admin_companies_path, notice: 'Company was successfully updated!' }
        format.turbo_stream { flash.now[:notice] = 'Company was successfully updated!' }
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @company
    @company.destroy
    respond_to do |format|
      format.html { redirect_to admin_companies_path, status: :see_other, notice: 'Company was successfully deleted!' }
      format.turbo_stream { flash.now[:notice] = 'Company was successfully deleted!' }
    end
  end

  private

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
