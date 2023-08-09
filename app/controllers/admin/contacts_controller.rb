class Admin::ContactsController < ApplicationController
  layout 'admin_layout'

  def index
    @pagy, @contacts = pagy(Contact.all, items: 15)
  end

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    redirect_to admin_contacts_path, notice: 'Contact was successfully deleted.'
  end

  def show
    @contact = Contact.find(params[:id])
  end
  
end
