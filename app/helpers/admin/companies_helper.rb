module Admin::CompaniesHelper
  def full_address(company)
    "#{company.address}, #{company.ward.name}, #{company.ward.district.name}, #{company.district.city.name}, Việt Nam"
  end
end
