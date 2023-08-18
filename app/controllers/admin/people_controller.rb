class Admin::PeopleController < ApplicationController
  layout 'admin_layout'

  before_action :prepare_data, only: %i[new create edit]
  before_action :prepare_person, only: %i[edit update destroy]
  before_action :prepare_data_filter, only: %i[index search]

  def search
    query = params[:q]&.strip&.downcase

    @persons = []

    @persons = Person.where("LOWER(people.cmnd) LIKE ? OR tax_codes.code LIKE ?", "%#{query}%", "%#{query}%").joins(:tax_code) if query.present?

    @pagy, @persons = pagy_array(@persons, items: 10)

    if @persons.blank?
      render 'no_result'
    else
      render 'index'
    end
  end

  def index
    authorize Person

    persons = Person.includes(:tax_code, :status, :company_type).all

    persons = persons.where(city_id: params[:city_id]) if params[:city_id].present?

    persons = persons.where(status_id: params[:status_id]) if params[:status_id].present?
    @pagy, @persons = pagy(persons, items: 10)
  end

  def new
    authorize Person
    @person = Person.new
  end

  def create
    @person = Person.new(person_params)
    authorize @person
    if @person.save
      redirect_to admin_people_path, notice: 'Person was successfully created!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    authorize @person
  end

  def update
    authorize @person
    if @person.update(person_params)
      redirect_to admin_people_path, notice: 'Person was successfully updated!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @person
    @person.destroy
    redirect_to admin_people_path, notice: 'Person was successfully deleted!'
  end

  def prepare_person
    @person = Person.find(params[:id])
  end

  def prepare_data
    @city_list = City.pluck(:name, :id)
    @company_type_list = CompanyType.pluck(:type_name, :id)
    @status_list = Status.pluck(:name, :id)
  end

  private

  def person_params
    params.require(:person).permit(:name, :cmnd, :date_start, :phone_number, :managed_by, :address, :city_id, :district_id, :ward_id, :company_type_id, :status_id)
  end

  def prepare_data_filter
    @cities = City.order(:id)
    @status_list = Status.pluck(:name, :id)
  end
end
