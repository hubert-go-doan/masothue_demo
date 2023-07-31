class MainController < ApplicationController
  def home
    @companies = Company.all
  end
end
