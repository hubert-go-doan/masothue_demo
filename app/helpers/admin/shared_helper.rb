module Admin::SharedHelper
  def full_address(addressable)
    "#{addressable.address}, #{addressable.ward.name}, #{addressable.district.name}, #{addressable.city.name}, Việt Nam"
  end
end

