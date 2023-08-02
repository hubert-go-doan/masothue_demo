class CompanyTypesController < ApplicationController

  before_action :prepare_cities, only: %i[index show]

  def index
    @company_types = CompanyType.all
  end

  def show
    @company_type = CompanyType.find(params[:id]) 
    @data = (@company_type.companies + @company_type.people).shuffle
    rescue ActiveRecord::RecordNotFound 
      redirect_to company_types_path   
  end
  
  private
    def prepare_cities
      @cities =  City.order(:id)
    end
end
