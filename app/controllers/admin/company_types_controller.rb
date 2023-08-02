class Admin::CompanyTypesController < ApplicationController
    layout 'admin_layout'
  
    def index
      @company_types = CompanyType.all
      @type_sum = CompanyType.count
      @company_sum = Company.count
      @person_sum = Person.count

      @type_counts = {}
      @company_counts = Company.group(:company_type_id).count
      @person_counts = Person.group(:company_type_id).count
  
      CompanyType.all.each do |company_type|
        company_type_id = company_type.id
        company_count = @company_counts.fetch(company_type_id, 0)
        person_count = @person_counts.fetch(company_type_id, 0)
        total_count = company_count + person_count
        @type_counts[company_type_id] = { company_count: company_count, person_count: person_count, total_count: total_count, type_name: company_type.type_name }
      end
    end
end