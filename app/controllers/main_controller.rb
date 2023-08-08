class MainController < ApplicationController
  before_action :prepare_cities, only: %i[home info_detail search]

  def home
    @data = (Company.all + Person.all).shuffle
  end

  def search
    query = params[:q]&.strip&.downcase
    city_id = params[:city_id]
    @results = []
    
    if query.present?
      @results += Company.where("LOWER(companies.name) LIKE ? OR LOWER(represents.name) LIKE ? OR tax_codes.code LIKE ?", "%#{query}%", "%#{query}%", "%#{query}%").joins(:represent, :tax_code)
      @results += Person.where("LOWER(people.name) LIKE ? OR tax_codes.code LIKE ?", "%#{query}%", "%#{query}%").joins(:tax_code)
    end
  
    if @results.count == 1
      result = @results.first
      type = result.class.name.downcase
      redirect_to info_detail_path(id: result.id, type: type)
    else
      render 'search_results'
    end
  end
  
  def info_detail
    @new_companies = Company.where("date_start >= ?", 20.days.ago).order(date_start: :desc)
    @new_persons = Person.where("date_start >= ?", 20.days.ago).order(date_start: :desc)
    @new_entity = (@new_companies + @new_persons).shuffle

    type = params[:type]
    id = params[:id]

    case type
    when 'company'
      @entity = Company.find(id)
      @related_companies_ward = Company.where(city_id: @entity.city_id, district_id: @entity.district_id, ward_id: @entity.ward_id).order("RANDOM()").limit(5)
      @related_companies_district = Company.where(city_id: @entity.city_id, district_id: @entity.district_id).order("RANDOM()").limit(5)
      @related_companies_city = Company.where(city_id: @entity.city_id).order("RANDOM()").limit(5)
      
      @related_wards = Ward.where(district_id: @entity.district_id)

      @breadcrumb_data = [
        { name: 'Tra cứu mã số thuế', path: root_path },
        { name: @entity.name, path: info_detail_path(id: @entity.id, type: 'company') }
      ]
    when 'person'
      @entity = Person.find(id)
    else
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
