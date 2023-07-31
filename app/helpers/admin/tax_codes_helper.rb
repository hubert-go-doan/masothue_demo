module Admin::TaxCodesHelper
  def full_addr(taxcode)
    "#{taxcode.taxable.address}, #{taxcode.taxable.ward.name}, #{taxcode.taxable.ward.district.name}, #{taxcode.taxable.district.city.name}, Việt Nam"
  end
end


