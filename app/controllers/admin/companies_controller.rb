class Admin::CompaniesController < ApplicationController
  layout 'admin_layout'

  def index 
    @companies = Company.all
  end

end
