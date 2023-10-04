class ChartsController < ApplicationController
  def index
    @current_year = Time.zone.today.year
    @start_year = @current_year - 10
    @selected_time = params[:time]
    @selected_year = params[:year] || @current_year
    @selected_month = params[:month]
    @selected_quarter = params[:quarter]
    query = build_query(@selected_year, @selected_month, @selected_quarter)

    @top_business_areas = calculate_top_business_areas(query)
    @top_cities = calculate_top_cities(query)
    @new_companies_data = calculate_new_companies_data
    @table_data = calculate_table_data(@new_companies_data)
    @company_types_data_current = calculate_company_types_data(query)
  end

  private

  def build_query(year, month, quarter)
    query = "EXTRACT(YEAR FROM companies.date_start) = '#{year}'"

    if month.present?
      query += " AND EXTRACT(MONTH FROM companies.date_start) = '#{month}'"
    end

    if quarter.present?
      case quarter
      when 'Quý 1'
        start_month = 1
        end_month = 3
      when 'Quý 2'
        start_month = 4
        end_month = 6
      when 'Quý 3'
        start_month = 7
        end_month = 9
      when 'Quý 4'
        start_month = 10
        end_month = 12
      end
      query += " AND EXTRACT(MONTH FROM companies.date_start) BETWEEN #{start_month} AND #{end_month}"
    end
    query
  end

  def calculate_top_business_areas(query)
    BusinessArea.left_joins(:companies)
      .where(query)
      .group('business_areas.name')
      .order('count(companies.id) DESC')
      .limit(10)
      .count('companies.id')
  end

  def calculate_top_cities(query)
    City.left_joins(companies: :status)
      .where('LOWER(statuses.name) LIKE ?', '%đang hoạt động%')
      .where(query)
      .group('cities.name')
      .order('count(companies.id) DESC')
      .limit(20)
      .count('companies.id')
  end

  def calculate_company_types_data(query)
    Company.left_joins(:company_type)
      .where('company_types.type_name != ?', 'Chưa update')
      .where(query)
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
