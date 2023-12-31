class MainController < ApplicationController
  before_action :prepare_cities, only: %i[home info_detail search]

  def home
    data_company = Company.order('RANDOM()').includes(:represent, :tax_code, :city, :district, :ward).limit(10)
    data_person = Person.order('RANDOM()').includes(:tax_code, :city, :district, :ward).limit(10)
    @data = (data_company + data_person).shuffle
  end

  def search
    query = params[:q]&.strip&.downcase
    city_id = params[:city_id]
    @results = []

    if query.present?
      company_results = Company
        .left_joins(:represent, :tax_code)
        .where("LOWER(companies.name) LIKE ? OR LOWER(represents.name) LIKE ? OR COALESCE(tax_codes.code, '') LIKE ?", "%#{query}%", "%#{query}%", "%#{query}%")
        .includes(:tax_code, :represent, :city, :district, :ward)
      person_results = Person
        .left_joins(:tax_code)
        .where("LOWER(people.name) LIKE ? OR LOWER(people.cmnd) LIKE ? OR COALESCE(tax_codes.code, '') LIKE ?", "%#{query}%", "%#{query}%", "%#{query}%")

      @results = company_results + person_results
    end

    @results = @results.select { |result| city_id.blank? || result.city_id == city_id.to_i }

    @pagy, @paginated_results = pagy_array(@results)

    if @results.count == 1
      result = @results.first
      type = result.class.name.downcase
      redirect_to info_detail_path(id: result.id, type:)
    else
      render 'search_results'
    end
  end

  def info_detail
    @new_companies = Company
      .where('date_start >= ?', 20.days.ago)
      .order(date_start: :desc)
      .includes(:represent, :tax_code, :city, :district, :ward)
    @new_persons = Person
      .where('date_start >= ?', 20.days.ago)
      .order(date_start: :desc)
      .includes(:tax_code, :city, :district, :ward)

    @pagy, @new_entity = pagy_array(@new_companies + @new_persons)

    type = params[:type]
    id = params[:id]

    case type
    when 'company'
      @entity = Company.find(id)

      @related_companies_ward = Company
        .where(ward_id: @entity.ward_id)
        .includes(:tax_code, :represent, :city, :district, :ward)
        .order('RANDOM()')
        .limit(5)

      @related_companies_district = Company
        .where(district_id: @entity.district_id)
        .includes(:tax_code, :represent, :city, :district, :ward)
        .order('RANDOM()')
        .limit(5)

      @related_companies_city = Company
        .where(city_id: @entity.city_id)
        .includes(:tax_code, :represent, :city, :district, :ward)
        .order('RANDOM()')
        .limit(5)

      @related_wards = Ward.where(district_id: @entity.district_id)

      @breadcrumb_data = [
        { name: 'Tra cứu mã số thuế', path: root_path },
        { name: @entity.name, path: info_detail_path(id: @entity.id, type: 'company') }
      ]
    when 'person'
      @entity = Person.find(id)
    end

    @breadcrumb_data = [
      { name: 'Tra cứu mã số thuế', path: root_path },
      { name: @entity.name, path: info_detail_path(id: @entity.id, type: 'person') }
    ]
  end

  private

  def prepare_cities
    @cities = City.order(:id)
  end
end
