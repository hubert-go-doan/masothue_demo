module Admin::SharedHelper
  def full_address(addressable)
    address_parts = addressable.address.split(',')
    district_name = addressable.district&.name
    ward_name = addressable.ward&.name
    city_name = addressable.city&.name

    if district_name.nil? || ward_name.nil? || city_name.nil?
      district_name = addressable.district&.name || District.find_by(id: addressable.district_id)&.name
      ward_name = addressable.ward&.name || Ward.find_by(id: addressable.ward_id)&.name
      city_name = addressable.city&.name || City.find_by(id: addressable.city_id)&.name
    end

    if address_parts.size >= 4
      "#{address_parts[0]}, #{address_parts[1..].join(', ')}"
    else
      "#{addressable.address}, #{ward_name}, #{district_name}, #{city_name}, Việt Nam"
    end
  end
end
