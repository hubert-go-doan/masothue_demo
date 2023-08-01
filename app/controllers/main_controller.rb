class MainController < ApplicationController
  def home
    @data = {
      companies: Company.all,
      persons: Person.all
    }
    @cities =  City.order(:id)
  end
end
