class TaxCodePersonalController < ApplicationController
  def index
    prepare_breadcrumb_data
  end

  def search
    query = params[:q]
    
    if query.present?
      @result = Person.where("people.cmnd LIKE ? OR tax_codes.code LIKE ?", "%#{query}%", "%#{query}%").joins(:tax_code)
    end
    if @result.blank? 
      render 'no_result'
    else 
      redirect_to info_detail_path(id: @result.ids, type: 'person')
    end
  end

  private
    def prepare_breadcrumb_data
      @breadcrumb_data = [
        { name: 'Tra cứu mã số thuế', path: root_path },
        { name: 'Mã số thuế cá nhân', path: tax_code_personal_index_path }
      ]
    end
end   
