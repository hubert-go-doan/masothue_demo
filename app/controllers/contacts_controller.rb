class ContactsController < ApplicationController
  def new
    @contact = Contact.new
    prepare_breadcrumb_data
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      redirect_to contacts_path, notice: "Contact sent successfully!"
    else
      prepare_breadcrumb_data
      render :new, status: :unprocessable_entity
    end
  end

  private

  def contact_params
    params.require(:contact).permit(
      :name,
      :email,
      :content
    )
  end

  def prepare_breadcrumb_data
    @breadcrumb_data = [
      { name: 'Tra cứu mã số thuế', path: root_path },
      { name: 'Liên hệ', path: contacts_path }
    ]
  end
end
