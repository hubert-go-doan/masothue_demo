class ContactsController < ApplicationController
  def index
    @contacts = Contact.all
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    
    if @contact.save
      redirect_to new_contact_path
    else
      render :new, status: :unprocessable_entity
    end
  end     

  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    redirect_to contacts_path, status: :see_other
  end

  private
    def contact_params
      params.require(:contact).permit(
        :name, 
        :email, 
        :content
      )
    end
end
