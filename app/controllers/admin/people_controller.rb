class Admin::PeopleController < Admin::BaseController
  before_action :prepare_data, only: %i[new create edit update]
  before_action :prepare_person, only: %i[edit update destroy show]
  before_action :prepare_data_filter, only: %i[index search]

  def search
    authorize Person
    query = params[:q]&.strip&.downcase
    @persons = []

    if query.present?
      @persons = Person
        .left_joins(:tax_code)
        .includes(:tax_code, :city, :district, :ward)
        .where("LOWER(people.name) LIKE ? OR LOWER(people.cmnd) LIKE ? OR COALESCE(tax_codes.code, '') LIKE ?", "%#{query}%", "%#{query}%", "%#{query}%")
    end

    @pagy, @persons = pagy_array(@persons, items: 10)

    if @persons.blank?
      render 'no_result'
    else
      render 'index'
    end
  end

  def show
    authorize Person
    redirect_to admin_person_path if @person.nil?
  end

  def index
    authorize Person
    persons = Person.includes(:tax_code, :ward, :district, :city).all
    persons = persons.where(city_id: params[:city_id]) if params[:city_id].present?
    persons = persons.where(status_id: params[:status_id]) if params[:status_id].present?
    @persons = persons.order(created_at: :asc)
    @pagy, @persons = pagy(@persons, items: 10)
  end

  def new
    authorize Person
    @person = Person.new
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          dom_id(@person), partial: 'form', locals: { person: @person }
        )
      end
      format.html
    end
  end

  def create
    @person = Person.new(person_params)
    authorize @person
    if @person.save
      respond_to do |format|
        format.html { redirect_to admin_people_path, notice: 'Person was successfully created!' }
        format.turbo_stream { flash.now[:notice] = 'Person was successfully created!' }
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
    authorize @person
  end

  def update
    authorize @person
    if @person.update(person_params)
      respond_to do |format|
        format.html { redirect_to admin_people_path, notice: 'Person was successfully updated!' }
        format.turbo_stream { flash.now[:notice] = 'Person was successfully updated!' }
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @person
    @person.destroy
    respond_to do |format|
      format.html { redirect_to admin_people_path, status: :see_other, notice: 'Person was successfully deleted!' }
      format.turbo_stream { flash.now[:notice] = 'Person was successfully deleted!' }
    end
  end

  private

  def prepare_person
    @person = Person.find(params[:id])
  end

  def prepare_data
    @city_list = City.pluck(:name, :id)
    @company_type_list = CompanyType.pluck(:type_name, :id)
    @status_list = Status.pluck(:name, :id)
  end

  def prepare_data_filter
    @cities = City.order(:id)
    @status_list = Status.pluck(:name, :id)
  end

  def person_params
    params.require(:person).permit(
      :name,
      :cmnd,
      :date_start,
      :phone_number,
      :managed_by,
      :address,
      :city_id,
      :district_id,
      :ward_id,
      :company_type_id,
      :status_id
    )
  end
end
