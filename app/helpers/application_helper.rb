module ApplicationHelper
  include Pagy::Frontend
  
  def breadcrumb_navigation
    current_page = request.fullpath

    crumbs = []
    crumbs << link_to('Tra cứu mã số thuế', root_path)

    if current_page.include?('status') 
      status_id = params[:id]
      if status_id.present?
        status = Status.find(status_id)
        crumbs << link_to('Trạng thái thuế', status_index_path)
        crumbs << status.name
      else
        crumbs << 'Trạng thái thuế'
      end
    elsif current_page.include?('business_areas')
      business_area_id = params[:id]
      if business_area_id.present?
        business_area = BusinessArea.find(business_area_id)
        crumbs << link_to('Ngành nghề', business_areas_path)
        crumbs << business_area.name
      else
        crumbs << 'Ngành nghề'
      end
    elsif current_page.include?('company_types')
      company_type_id = params[:id]
      if company_type_id.present?
        company_type = CompanyType.find(company_type_id)
        crumbs << link_to('Loại hình doanh nghiệp', company_types_path)
        crumbs << company_type.type_name
      else
        crumbs << 'Loại hình doanh nghiệp'
      end
    elsif current_page.include?('cities/ward')
      ward_id = params[:id]
      if ward_id.present?
        ward = Ward.find(ward_id)
        city = ward.district.city
        crumbs << link_to('Tỉnh thành phố', cities_path)
        crumbs << link_to(city.name, city_path(city))
        crumbs << link_to(ward.district.name, district_path(ward.district))
        crumbs << ward.name
      else
        crumbs << link_to('Tỉnh thành phố', cities_path)
      end
    elsif current_page.include?('cities/district')
      district_id = params[:id]
      if district_id.present?
        district = District.find(district_id)
        city = district.city
        crumbs << link_to('Tỉnh thành phố', cities_path)
        crumbs << link_to(city.name, city_path(city))
        crumbs << district.name
      else
        crumbs << link_to('Tỉnh thành phố', cities_path)
      end
    elsif current_page.include?('cities')
      city_id = params[:id]
      if city_id.present?
        city = City.find(city_id)
        crumbs << link_to('Tỉnh thành phố', cities_path)
        crumbs << city.name
      else
        crumbs << 'Tỉnh thành phố'
      end
    else
      if current_page.include?('contacts')
        crumbs << 'Liên hệ'
      elsif current_page.include?('newly_established')
        crumbs << 'Doanh nghiệp mới thành lập'
      end
    end
    crumbs.join(' > ').html_safe
  end
end
