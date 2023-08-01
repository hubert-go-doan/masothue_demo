module Admin::SharedHelper
  def full_address(addressable)
    "#{addressable.address}, #{addressable.ward.name}, #{addressable.ward.district.name}, #{addressable.district.city.name}, Việt Nam"
  end
end
