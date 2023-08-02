# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create Contact
# Contact.create(
#   name: "HUBERT",
#   email: 'bao@gmail,com',
#   content: 'Day la noi dung...'
# )

# # Create City
# City.create(
#   name: 'Hồ Chí Minh',
# )

# District.create(
#   name: "Q1",
#   city_id: 1
# )

# District.create(
#   name: "Q2",
#   city_id: 1
# )

# District.create(
#   name: "Cam Le",
#   city_id: 2
# )

# Ward.create(
#   name: 'Phường 25',
#   district_id: 1
# )

# Ward.create(
#   name: 'Phường 22',
#   district_id: 2
# )

# Status.create(
#   name: "Tam Ngung"
# )

# Represent.create(
#   name: "Nguyen Thuy Hai",
#   day_of_birth: Date.new(1999,1,16)
# )

# BusinessArea.create(
#   name: "IT Phan Mem",
# )

# CompanyType.create(
#   type_name: "Cong ty Co phan",
# )

# CompanyType.create(
#   type_name: "Cong ty Tu Nhan",
# )

# Company.create(
#   name: "Công Ty BDS",
#   sub_name: "BDS",
#   address: "Tòa MB, Dien bien phu",
#   date_start: Date.today,
#   phone_number: "0343437623",
#   managed_by: "Chi cục thuế Quận 2",
#   city_id: 1, 
#   district_id: 2, 
#   ward_id: 1, 
#   company_type_id: 1, 
#   business_area_id: 1, 
#   represent_id: 1,
#   status_id: 1 
# )


# Person.create(
#   name: "Nguyen Doan Bao",
#   cmnd: "88484848484",
#   address: "123 Ha Noi",
#   date_start: Date.today,
#   phone_number: "0192726333",
#   managed_by: "Chi cục thuế Quận 22",
#   city_id: 1, 
#   district_id: 1, 
#   ward_id: 1, 
#   company_type_id: 1, 
#   status_id: 1 
# )

# CITIES = [
#   "Hải Phòng",
#   "Đà Nẵng",
#   "Cần Thơ",
#   "An Giang",
#   "Bà Rịa - Vũng Tàu",
#   "Bạc Liêu",
#   "Bắc Kạn",
#   "Bắc Giang",
#   "Bắc Ninh",
#   "Bến Tre",
#   "Bình Dương",
#   "Bình Định",
#   "Bình Phước",
#   "Bình Thuận",
#   "Cà Mau",
#   "Cao Bằng",
#   "Đắk Lắk",
#   "Đắk Nông",
#   "Điện Biên",
#   "Đồng Nai",
#   "Đồng Tháp",
#   "Gia Lai",
#   "Hà Giang",
#   "Hà Nam",
#   "Hà Tĩnh",
#   "Hải Dương",
#   "Hậu Giang",
#   "Hòa Bình",
#   "Hưng Yên",
#   "Khánh Hòa",
#   "Kiên Giang",
#   "Kon Tum",
#   "Lai Châu",
#   "Lâm Đồng",
#   "Lạng Sơn",
#   "Lào Cai",
#   "Long An",
#   "Nam Định",
#   "Nghệ An",
#   "Ninh Bình",
#   "Ninh Thuận",
#   "Phú Thọ",
#   "Quảng Bình",
#   "Quảng Nam",
#   "Quảng Ngãi",
#   "Quảng Ninh",
#   "Quảng Trị",
#   "Sóc Trăng",
#   "Sơn La",
#   "Tây Ninh",
#   "Thái Bình",
#   "Thái Nguyên",
#   "Thanh Hóa",
#   "Thừa Thiên Huế",
#   "Tiền Giang",
#   "Trà Vinh",
#   "Tuyên Quang",
#   "Vĩnh Long",
#   "Vĩnh Phúc",
#   "Yên Bái",
#   "Phú Yên"
# ]

# CITIES.each do |city_name|
#   City.create(name: city_name)
# end


# TaxCode.create(
#   code: "121212",
#   taxable_type: "Company",
#   taxable_id: 
# )

BUSINESS_AREA = [
  "Bán buôn máy móc, thiết bị và phụ tùng máy khác",
  "Đại lý, môi giới, đấu giá",
  "Bán buôn đồ dùng khác cho gia đình",
  "Dịch vụ liên quan đến in",
  "Hoàn thiện công trình xây dựng",
  "Quảng cáo",
  "Cắt tóc, làm đầu, gội đầu",
  "Bán buôn máy vi tính, thiết bị ngoại vi và phần mềm",
  "Bán buôn thiết bị và linh kiện điện tử, viễn thông",
  "Bán buôn thực phẩm",
  "Xây dựng nhà các loại"
]

BUSINESS_AREA.each do |busi|
  BusinessArea.create(name: busi)
end
