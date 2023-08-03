class StatusController < ApplicationController
  before_action :prepare_cities, only: %i[index show]

  def index
    @statuses = Status.all
  end

  def show
    @status = Status.find(params[:id]) 
    @data = (@status.companies + @status.people).shuffle
    rescue ActiveRecord::RecordNotFound 
      redirect_to status_index_path   
  end
  
  private
    def prepare_cities
      @cities =  City.order(:id)
    end
end
