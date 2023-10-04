class ChartsController < ApplicationController
  def index
    @current_year = Time.zone.today.year
    @start_year = @current_year - 10
    @selected_year = params[:year] || @current_year
    @top_business_areas = calculate_top_business_areas(@selected_year)
    @top_cities = calculate_top_cities(@selected_year)
    @new_companies_data = calculate_new_companies_data
    @table_data = calculate_table_data(@new_companies_data)
    @company_types_data_current = calculate_company_types_data(@selected_year)
  end

  private

  def calculate_top_business_areas(year)
    BusinessArea.left_joins(:companies)
      .where('EXTRACT(YEAR FROM companies.date_start) = ?', year)
      .group('business_areas.name')
      .order('count(companies.id) DESC')
      .limit(10)
      .count('companies.id')
  end

  def calculate_top_cities(year)
    City.left_joins(companies: :status)
      .where('LOWER(statuses.name) LIKE ?', '%đang hoạt động%')
      .where('EXTRACT(YEAR FROM companies.date_start) = ?', year)
      .group('cities.name')
      .order('count(companies.id) DESC')
      .limit(20)
      .count('companies.id')
  end

  def calculate_company_types_data(year)
    Company.left_joins(:company_type)
      .where('company_types.type_name != ?', 'Chưa update')
      .where('EXTRACT(YEAR FROM companies.date_start) = ?', year)
      .group('company_types.type_name')
      .count
  end

  def calculate_new_companies_data
    start_date = Date.new(@start_year).beginning_of_year
    end_date = Time.zone.today.end_of_year

    companies = Company.where(date_start: start_date..end_date)
    new_companies_data = companies.group_by { |company| company.date_start.year }
    new_companies_data.transform_values!(&:count).sort_by { |year, _| year }.to_h
  end

  def calculate_table_data(new_companies_data)
    new_companies_data.map { |year, count| { year:, count: } }
  end
end
