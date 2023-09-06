import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["citySelect", "districtSelect", "wardSelect"];

  connect() {
    console.log("Connected!");
  }

  updateDistricts() {
    const selectedCityId = this.citySelectTarget.value;
    console.log("selectedCityId: ", selectedCityId);

    if (selectedCityId) {
      fetch(`/admin/districts_by_city?city_id=${selectedCityId}`)
        .then((response) => response.json())
        .then((data) => {
          console.log("data!", data);
          this.districtSelectTarget.innerHTML = '<option value="">Chọn quận</option>';
          this.wardSelectTarget.innerHTML = '<option value="">Chọn phường</option>';

          data.forEach((district) => {
            this.districtSelectTarget.insertAdjacentHTML(
              "beforeend",
              `<option value="${district.id}">${district.name}</option>`
            );
          });
        });
    } else {
      this.districtSelectTarget.innerHTML = '<option value="">Chọn quận</option>';
      this.wardSelectTarget.innerHTML = '<option value="">Chọn phường</option>';
    }
  }

  updateWards() {
    const selectedDistrictId = this.districtSelectTarget.value;

    if (selectedDistrictId) {
      fetch(`/admin/wards_by_district?district_id=${selectedDistrictId}`)
        .then((response) => response.json())
        .then((data) => {
          this.wardSelectTarget.innerHTML = '<option value="">Chọn phường</option>';

          data.forEach((ward) => {
            this.wardSelectTarget.insertAdjacentHTML(
              "beforeend",
              `<option value="${ward.id}">${ward.name}</option>`
            );
          });
        });
    } else {
      this.wardSelectTarget.innerHTML = '<option value="">Chọn phường</option>';
    }
  }
}
