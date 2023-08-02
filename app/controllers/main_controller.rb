class MainController < ApplicationController
  def home
    @data = (Company.all + Person.all).shuffle
    @cities =  City.order(:id)
  end
end
