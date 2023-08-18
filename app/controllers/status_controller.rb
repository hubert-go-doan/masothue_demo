class StatusController < ApplicationController
  before_action :prepare_cities, only: %i[index show]

  def index
    @statuses = Status.all
    prepare_breadcrumb_data
  end

  def show
    @status = Status.find_by(id: params[:id])
    redirect_to status_index_path if @status.nil?
    @pagy, @data = pagy_array((@status.companies.includes(:tax_code, :represent, :city, :district, :ward) + @status.people.includes(:tax_code, :city, :district, :ward)).sort_by(&:date_start).reverse)

    prepare_breadcrumb_data unless @status.nil?
  end

  private

  def prepare_cities
    @cities = City.order(:id)
  end

  def prepare_breadcrumb_data
    @breadcrumb_data = [
      { name: 'Tra cứu mã số thuế', path: root_path },
      { name: 'Trạng thái thuế', path: status_index_path }
    ]
    @breadcrumb_data << { name: @status.name, path: status_path(@status) } if action_name == 'show'
  end
end
