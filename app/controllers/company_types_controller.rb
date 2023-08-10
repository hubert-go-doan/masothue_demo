class CompanyTypesController < ApplicationController

  before_action :prepare_cities, only: %i[index show]

  def index
    @company_types = CompanyType.all
    prepare_breadcrumb_data
  end

  def show
    @company_type = CompanyType.find_by(id: params[:id])
    redirect_to company_types_path if @company_type.nil?
    @pagy, @data = pagy_array((@company_type.companies + @company_type.people).sort_by(&:date_start).reverse)

    prepare_breadcrumb_data unless @company_type.nil?
  end
  
  private
    def prepare_cities
      @cities =  City.order(:id)
    end

    def prepare_breadcrumb_data
      @breadcrumb_data = [
        { name: 'Tra cứu mã số thuế', path: root_path },
        { name: 'Loại hình doanh nghiệp', path: company_types_path }
      ]
      @breadcrumb_data << { name: @company_type.type_name, path: company_type_path(@company_type) } if action_name == 'show'
    end
end
