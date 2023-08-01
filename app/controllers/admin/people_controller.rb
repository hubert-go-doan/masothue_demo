class Admin::PeopleController < ApplicationController
  layout 'admin_layout'

  before_action :prepare_data, only: %i[new create edit]
  before_action :prepare_person, only: %i[edit update destroy]

  def index
    @persons = Person.all
  end

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(person_params)
    if @person.save
      redirect_to admin_people_path, notice: 'Person was successfully created!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @person.update(person_params)
      redirect_to admin_people_path, notice: 'Person was successfully updated!'
    else
      render :edit, status: :unprocessable_entity
    end 
  end

  def destroy
    @person.destroy
    redirect_to admin_people_path, notice: 'Person was successfully destroyed.'
  end


  def prepare_person
    @person = Person.find(params[:id])
  end
  
  def prepare_data
    @city_list = City.all.map { |city| [city.name, city.id] }
    @company_type_list = CompanyType.all.map { |com_type| [com_type.type_name, com_type.id] }
    @status_list = Status.all.map { |status| [status.name, status.id] }
  end

  private

  def person_params
    params.require(:person).permit(:name, :cmnd, :date_start, :phone_number, :managed_by, :address, :city_id, :district_id, :ward_id, :company_type_id, :status_id)
  end
end
