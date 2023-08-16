# # # This file should contain all the record creation needed to seed the database with its default values.
# # # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# # #
# # # Examples:
# # #
# # #   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
# # #   Character.create(name: "Luke", movie: movies.first)


#  Created data City
CITIES = [
  "Hải Phòng",
  "Đà Nẵng",
  "Cần Thơ",
  "An Giang",
  "Bà Rịa - Vũng Tàu",
  "Bạc Liêu",
  "Bắc Kạn",
  "Bắc Giang",
  "Bắc Ninh",
  "Bến Tre",
  "Bình Dương",
  "Bình Định",
  "Bình Phước",
  "Bình Thuận",
  "Cà Mau",
  "Cao Bằng",
  "Đắk Lắk",
  "Đắk Nông",
  "Điện Biên",
  "Đồng Nai",
  "Đồng Tháp",
  "Gia Lai",
  "Hà Giang",
  "Hà Nam",
  "Hà Tĩnh",
  "Hải Dương",
  "Hậu Giang",
  "Hòa Bình",
  "Hưng Yên",
  "Khánh Hòa",
  "Kiên Giang",
  "Kon Tum",
  "Lai Châu",
  "Lâm Đồng",
  "Lạng Sơn",
  "Lào Cai",
  "Long An",
  "Nam Định",
  "Nghệ An",
  "Ninh Bình",
  "Ninh Thuận",
  "Phú Thọ",
  "Quảng Bình",
  "Quảng Nam",
  "Quảng Ngãi",
  "Quảng Ninh",
  "Quảng Trị",
  "Sóc Trăng",
  "Sơn La",
  "Tây Ninh",
  "Thái Bình",
  "Thái Nguyên",
  "Thanh Hóa",
  "Thừa Thiên Huế",
  "Tiền Giang",
  "Trà Vinh",
  "Tuyên Quang",
  "Vĩnh Long",
  "Vĩnh Phúc",
  "Yên Bái",
  "Phú Yên"
]

CITIES.each do |city_name|
  City.create(name: city_name)
end

# Create data district

districts_data = [
  { name: "Q1", city_id: 1 },
  { name: "Q3", city_id: 1 },
  { name: "Q2", city_id: 1 },
  { name: "Hòa Khánh", city_id: 2 },
  { name: "Hòa Vang", city_id: 2 },
  { name: "Minh Thanh", city_id: 3 },
  { name: "Hai Bà Trưng", city_id: 3 },
  { name: "Thanh Xuân", city_id: 3 }
]

districts_data.each do |district_params|
  District.create(district_params)
end


# Create data ward

wards_data = [
  { name: 'Phường 1', district_id: 1 },
  { name: 'Phường 10', district_id: 2 },
  { name: 'Phường 18', district_id: 2 },
  { name: 'Phường 2', district_id: 3 },
  { name: 'Phường 8', district_id: 4 },
  { name: 'Phường 27', district_id: 2 },
  { name: 'Phường 12', district_id: 7 },
  { name: 'Phường 9', district_id: 3 },
  { name: 'Phường 5', district_id: 6 },
  { name: 'Phường 41', district_id: 5 },
  { name: 'Phường 25', district_id: 1 }
]

wards_data.each do |ward_params|
  Ward.create(ward_params)
end

#  Create data Business Areas
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


#  Create Data Represent
REPRESENT = [
  "Đoàn Quốc Bảo",
  "Nguyễn Ngọc Phương Vy",
  "Bùi Xuân Hạnh",
  "Nguyễn Minh Tuấn",
  "Nguyễn Hương Liên",
  "Phạm Tuấn Ngọc",
]
REPRESENT.each do |represent|
  Represent.create(name: represent)
end


# create data status

STATUS = [
  "NNT ngừng hoạt động nhưng chưa hoàn thành thủ tục đóng MST",
  "NNT đang hoạt động (đã được cấp GCN ĐKT)",
  "NNT ngừng hoạt động và đã đóng MST",
  "NNT tạm nghỉ kinh doanh có thời hạn",
  "NNT đang hoạt động (được cấp thông báo MST)",
  "NNT đã chuyển cơ quan thuế quản lý",
  "NNT không hoạt động tại địa chỉ đã đăng ký"
]

STATUS.each do |status|
  Status.create(name: status)
end

# create data company type
COMPANY_TYPE = [
  "Công ty trách nhiệm hữu hạn 1 thành viên ngoài NN",
  "Doanh nghiệp tư nhân",
  "Công ty cổ phần NN",
  "Công ty trách nhiệm hữu hạn 2 thành viên trở lên ngoài NN",
  "Công ty cổ phần ngoài NN",
  "Công ty trách nhiệm hữu hạn NN 1 thành viên",
  "Công ty trách nhiệm hữu hạn NN 2 thành viên trở lên",
  "Các tổ chức kinh tế khác",
  "Doanh nghiệp 100% vốn đầu tư nước ngoài",
  "Doanh nghiệp 100% vốn nhà nước hoạt động theo Luật DNNN",
  "Công ty hợp doanh",
  "Hợp tác xã",
  "Đơn vị hành chính, đơn vị sự nghiệp",
  "Tổ chức kinh tế của tổ chức CT, CT-XH, XH, XH-NN",
  "Doanh nghiệp liên doanh với nước ngoài",
  "Hộ kinh doanh cá thể"
]

COMPANY_TYPE.each do |company_type|
  CompanyType.create(type_name: company_type)
end

# create data company

company_data = [
  {
    name: "Công Ty BDS",
    sub_name: "BDS",
    address: "Tòa MB, Điện Biên Phủ",
    date_start: Date.today,
    phone_number: "0343437623",
    managed_by: "Chi cục thuế Quận 2",
    city_id: 1,
    district_id: 2,
    ward_id: 1,
    company_type_id: 1,
    business_area_id: 1,
    represent_id: 1,
    status_id: 1
  },
  {
    name: "Công Ty Công Nghệ",
    sub_name: "Tech",
    address: "Số 123, Đường ABC, Quận XYZ",
    date_start: Date.today - 1,
    phone_number: "0987654321",
    managed_by: "Chi cục thuế Quận 10",
    city_id: 2,
    district_id: 2,
    ward_id: 3,
    company_type_id: 2,
    business_area_id: 2,
    represent_id: 2,
    status_id: 2
  },
  {
    name: "Công Ty Thời Trang",
    sub_name: "Fashion",
    address: "123 Phố Fashion, Quận Style",
    date_start: Date.today - 30,
    phone_number: "0123456789",
    managed_by: "Chi cục thuế Quận 7",
    city_id: 3,
    district_id: 3,
    ward_id: 4,
    company_type_id: 3,
    business_area_id: 3,
    represent_id: 3,
    status_id: 3
  },
  {
    name: "Công Ty Xây Dựng",
    sub_name: "Construction",
    address: "456 Đường Xây Dựng, Quận Building",
    date_start: Date.today - 15,
    phone_number: "0765432109",
    managed_by: "Chi cục thuế Quận 4",
    city_id: 4,
    district_id: 2,
    ward_id: 2,
    company_type_id: 4,
    business_area_id: 4,
    represent_id: 4,
    status_id: 4
  },
  {
    name: "Công Ty Logistics",
    sub_name: "Logistics",
    address: "789 Đường Logistics, Quận Ship",
    date_start: Date.today - 10,
    phone_number: "0912345678",
    managed_by: "Chi cục thuế Quận 1",
    city_id: 5,
    district_id: 1,
    ward_id: 4,
    company_type_id: 5,
    business_area_id: 5,
    represent_id: 5,
    status_id: 5
  },
  {
    name: "Công Ty Thực Phẩm",
    sub_name: "Food",
    address: "555 Phố Food, Quận Yummy",
    date_start: Date.today - 20,
    phone_number: "0888888888",
    managed_by: "Chi cục thuế Quận 3",
    city_id: 1,
    district_id: 1,
    ward_id: 6,
    company_type_id: 6,
    business_area_id: 6,
    represent_id: 1,
    status_id: 6
  },
  {
    name: "Công Ty Du Lịch",
    sub_name: "Travel",
    address: "777 Đường Travel, Quận Explore",
    date_start: Date.today - 5,
    phone_number: "0777777777",
    managed_by: "Chi cục thuế Quận 5",
    city_id: 2,
    district_id: 2,
    ward_id: 7,
    company_type_id: 2,
    business_area_id: 1,
    represent_id: 2,
    status_id: 5
  },
  {
    name: "Công Ty Dược Phẩm",
    sub_name: "Pharmacy",
    address: "222 Phố Pharmacy, Quận Health",
    date_start: Date.today - 25,
    phone_number: "0666666666",
    managed_by: "Chi cục thuế Quận 6",
    city_id: 4,
    district_id: 4,
    ward_id: 4,
    company_type_id: 2,
    business_area_id: 2,
    represent_id: 3,
    status_id: 3
  },
  {
    name: "Công Ty Ô Tô",
    sub_name: "Car",
    address: "111 Đường Car, Quận Auto",
    date_start: Date.today - 7,
    phone_number: "0555555555",
    managed_by: "Chi cục thuế Quận 8",
    city_id: 1,
    district_id: 1,
    ward_id: 1,
    company_type_id: 2,
    business_area_id: 2,
    represent_id: 2,
    status_id: 2
  },
  {
    name: "Công Ty Y Tế",
    sub_name: "Healthcare",
    address: "999 Phố Healthcare, Quận Medical",
    date_start: Date.today - 12,
    phone_number: "0999999999",
    managed_by: "Chi cục thuế Quận 9",
    city_id: 2,
    district_id: 3,
    ward_id: 3,
    company_type_id: 2,
    business_area_id: 3,
    represent_id: 1,
    status_id: 1
  }
]

company_data.each do |company_params|
  Company.create(company_params)
end

# create data perrson

person_data = [
  {
    name: "Nguyen Doan Bao",
    cmnd: "88484848484",
    address: "123 Hà Nội",
    date_start: Date.today,
    phone_number: "0192726333",
    managed_by: "Chi cục thuế Quận 22",
    city_id: 1,
    district_id: 1,
    ward_id: 1,
    company_type_id: 1,
    status_id: 1
  },
  {
    name: "Tran Van Anh",
    cmnd: "9988776655",
    address: "456 TP.HCM",
    date_start: Date.today - 1,
    phone_number: "0345678912",
    managed_by: "Chi cục thuế Quận 10",
    city_id: 1,
    district_id: 2,
    ward_id: 2,
    company_type_id: 2,
    status_id: 2
  },
  {
    name: "Le Thi Mai",
    cmnd: "7766554433",
    address: "789 Đà Nẵng",
    date_start: Date.today - 10,
    phone_number: "0777888999",
    managed_by: "Chi cục thuế Quận 5",
    city_id: 2,
    district_id: 3,
    ward_id: 1,
    company_type_id: 3,
    status_id: 1
  },
  {
    name: "Pham Van Hoa",
    cmnd: "1122334455",
    address: "555 Hải Phòng",
    date_start: Date.today - 5,
    phone_number: "0987654321",
    managed_by: "Chi cục thuế Quận 8",
    city_id: 2,
    district_id: 1,
    ward_id: 3,
    company_type_id: 3,
    status_id: 4
  },
  {
    name: "Do Minh Hieu",
    cmnd: "5544332211",
    address: "333 Huế",
    date_start: Date.today - 15,
    phone_number: "0888777666",
    managed_by: "Chi cục thuế Quận 3",
    city_id: 3,
    district_id: 2,
    ward_id: 1,
    company_type_id: 3,
    status_id: 1
  },
  {
    name: "Nguyen Thanh Thao",
    cmnd: "3322110055",
    address: "666 Quảng Ninh",
    date_start: Date.today - 20,
    phone_number: "0912345678",
    managed_by: "Chi cục thuế Quận 6",
    city_id: 1,
    district_id: 1,
    ward_id: 1,
    company_type_id: 1,
    status_id: 1
  },
  {
    name: "Tran Anh Tuan",
    cmnd: "5566778899",
    address: "777 Bình Dương",
    date_start: Date.today - 7,
    phone_number: "0999888777",
    managed_by: "Chi cục thuế Quận 7",
    city_id: 2,
    district_id: 4,
    ward_id: 2,
    company_type_id: 1,
    status_id: 3
  },
  {
    name: "Le Minh Duc",
    cmnd: "9988776655",
    address: "888 Long An",
    date_start: Date.today - 25,
    phone_number: "0123456789",
    managed_by: "Chi cục thuế Quận 9",
    city_id: 4,
    district_id: 2,
    ward_id: 1,
    company_type_id: 4,
    status_id: 3
  },
  {
    name: "Pham Van Hoang",
    cmnd: "6655443322",
    address: "999 Cần Thơ",
    date_start: Date.today - 12,
    phone_number: "0987654321",
    managed_by: "Chi cục thuế Quận 12",
    city_id: 3,
    district_id: 1,
    ward_id: 2,
    company_type_id: 2,
    status_id: 1
  },
  {
    name: "Nguyen Thi Lan",
    cmnd: "8899001122",
    address: "101 Sóc Trăng",
    date_start: Date.today - 30,
    phone_number: "0912345678",
    managed_by: "Chi cục thuế Quận 1",
    city_id: 3,
    district_id: 2,
    ward_id: 3,
    company_type_id: 2,
    status_id: 4
  }
]

person_data.each do |person_params|
  Person.create(person_params)
end


# Create data tax-code 
companies_ids = Company.pluck(:id)
persons_ids = Person.pluck(:id)

tax_code_data = [
  { code: "121212", taxable_type: "Company", taxable_id: companies_ids.sample },
  { code: "343434", taxable_type: "Company", taxable_id: companies_ids.sample },
  { code: "565656", taxable_type: "Company", taxable_id: companies_ids.sample },
  { code: "787878", taxable_type: "Person", taxable_id: persons_ids.sample },
  { code: "909090", taxable_type: "Person", taxable_id: persons_ids.sample },
  { code: "232323", taxable_type: "Person", taxable_id: persons_ids.sample },
]

tax_code_data.each do |tax_code_params| 
  TaxCode.create(tax_code_params)
end

# # Create user admin
User.create(
  email: "ncphuong16@gmail.com",
  password: "123123"
)
