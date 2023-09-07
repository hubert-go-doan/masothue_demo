class Admin::ContactsController < Admin::BaseController
  def index
    authorize Contact
    @pagy, @contacts = pagy(Contact.all, items: 10)
  end

  def destroy
    @contact = Contact.find(params[:id])
    authorize @contact
    @contact.destroy
    redirect_to admin_contacts_path, notice: 'Contact was successfully deleted!'
  end
end
