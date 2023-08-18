class Admin::TaxCodesController < ApplicationController
  layout 'admin_layout'

  OBJECT_TAXCODE = %w[Company Person].freeze

  before_action :fetch_taxable_types, only: %i[new create]

  def search
    query = params[:q]&.strip&.downcase
    @pagy, @tax_codes = pagy_array([])

    @tax_codes = TaxCode.where("tax_codes.code LIKE ? ", "%#{query}%").includes(taxable: %i[represent city district ward]) if query.present?

    if @tax_codes.blank?
      render 'no_result'
    else
      render 'index'
    end
  end

  def index
    authorize TaxCode
    tax_codes = TaxCode.includes(taxable: %i[represent city district ward]).all
    tax_codes = tax_codes.where(taxable_type: params[:taxable_type]) if params[:taxable_type].present?
    @pagy, @tax_codes = pagy(tax_codes, items: 10)
  end

  def company_options
    @taxable_objects = Company.where.not(id: TaxCode.where(taxable_type: 'Company').pluck(:taxable_id))
    render json: @taxable_objects
  end

  def person_options
    @taxable_objects = Person.where.not(id: TaxCode.where(taxable_type: 'Person').pluck(:taxable_id))
    render json: @taxable_objects
  end

  def new
    authorize TaxCode
    @tax_code = TaxCode.new
  end

  def create
    @tax_code = TaxCode.new(taxcode_params)
    authorize @tax_code
    if @tax_code.save
      redirect_to admin_tax_codes_path, notice: 'Tax Code was successfully created!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @tax_code = TaxCode.find(params[:id])
    authorize @tax_code
    @tax_code.destroy
    redirect_to admin_tax_codes_path, status: :see_other, notice: 'Tax Code was successfully deleted!'
  end

  def fetch_taxable_types
    @taxable_types = OBJECT_TAXCODE
  end

  def render_taxable_objects
    render json: @taxable_objects
  end

  private

  def taxcode_params
    params.require(:tax_code).permit(:code, :taxable_type, :taxable_id)
  end
end
