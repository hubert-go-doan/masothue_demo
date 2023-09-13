class ChartsController < ApplicationController
  def index
    @current_year = Time.zone.today.year
    @start_year = @current_year - 10
    @top_business_areas = calculate_top_business_areas
    @top_cities = calculate_top_cities
    @new_companies_data = calculate_new_companies_data
    @table_data = calculate_table_data(@new_companies_data)
    @company_types_data_current = calculate_company_types_data(@current_year, 8)
    @company_types_data_prev = calculate_company_types_data(@current_year - 1, 8)
    @total_companies_current = @company_types_data_current.values.sum
    @total_companies_prev = @company_types_data_prev.values.sum
    @percentage_change = calculate_percentage_change
  end

  private

  def calculate_top_business_areas
    BusinessArea.left_joins(:companies)
      .group('business_areas.name')
      .order('count(companies.id) DESC')
      .limit(10)
      .count('companies.id')
  end

  def calculate_top_cities
    City.left_joins(companies: :status)
      .where('LOWER(statuses.name) LIKE ?', '%đang hoạt động%')
      .group('cities.name')
      .order('COUNT(companies.id) DESC')
      .limit(20)
      .count('companies.id')
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

  def calculate_company_types_data(year, month)
    Company.joins(:company_type)
      .where('extract(year from date_start) = ? AND extract(month from date_start) <= ?', year, month)
      .group('company_types.type_name')
      .count
  end

  def calculate_percentage_change
    (((@total_companies_current - @total_companies_prev).to_f / @total_companies_prev) * 100).round(2)
  end
end
