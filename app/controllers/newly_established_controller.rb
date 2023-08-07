class NewlyEstablishedController < ApplicationController
  def index
    @cities =  City.order(:id)
    @new_companies = Company.where("date_start >= ?", 20.days.ago).order(date_start: :desc)

    @breadcrumb_data = [
      { name: 'Tra cứu mã số thuế', path: root_path },
      { name: 'Doanh nghiệp mới thành lập', path: '' }
    ]
  end
end
