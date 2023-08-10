class Admin::TaxCodesController < ApplicationController
  layout 'admin_layout'
  
  OBJECT_TAXCODE = %w[Company Person]

  before_action :fetch_taxable_types, only: %i[new create]

  def index
    @pagy, @tax_codes = pagy(TaxCode.includes(:taxable).all, items: 15)
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
    @tax_code = TaxCode.new
  end

  def create
    @tax_code = TaxCode.new(taxcode_params)
    if @tax_code.save 
      redirect_to admin_tax_codes_path
    else 
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @tax_code = TaxCode.find(params[:id])
    @tax_code.destroy
    redirect_to admin_tax_codes_path, status: :see_other
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
