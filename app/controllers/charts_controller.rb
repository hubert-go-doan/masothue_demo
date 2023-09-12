class ChartsController < ApplicationController
  def index
    @top_business_areas = BusinessArea.left_joins(:companies)
      .group('business_areas.name')
      .order('count(companies.id) DESC')
      .limit(10)
      .count('companies.id')

    @top_cities = City.left_joins(companies: :status)
      .where('LOWER(statuses.name) LIKE ?', '%đang hoạt động%')
      .group('cities.name')
      .order('COUNT(companies.id) DESC')
      .limit(20)
      .count('companies.id')

    new_companies_data = {}

    current_year = Time.zone.today.year

    (2013..current_year).each do |year|
      new_companies_count = Company.where('extract(year from date_start) = ?', year).count
      new_companies_data[year] = new_companies_count
    end
    @new_companies_data = new_companies_data
    @table_data = new_companies_data.map { |year, count| { year:, count: } }

    @company_types_data_current = Company.joins(:company_type)
      .where('extract(year from date_start) = ? AND extract(month from date_start) <= ?', 2023, 8)
      .group('company_types.type_name')
      .count

    @company_types_data_prev = Company.joins(:company_type)
      .where('extract(year from date_start) = ? AND extract(month from date_start) <= ?', 2022, 8)
      .group('company_types.type_name')
      .count

    @total_companies_current = @company_types_data_current.values.sum
    @total_companies_prev = @company_types_data_prev.values.sum

    @percentage_change = (((@total_companies_current - @total_companies_prev).to_f / @total_companies_prev) * 100).round(2)
  end
end
