class NewlyEstablishedController < ApplicationController
  def index
    @cities = City.order(:id)
    @pagy, @new_companies = pagy(Company.where("date_start >= ?", 20.days.ago).order(date_start: :desc).includes(:tax_code, :represent, :city, :district, :ward))

    @breadcrumb_data = [
      { name: 'Tra cứu mã số thuế', path: root_path },
      { name: 'Doanh nghiệp mới thành lập', path: '' }
    ]
  end
end
