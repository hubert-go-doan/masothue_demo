import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.disableSelectFields();
  }

  disableSelectFields() {
    const citySelect = document.getElementById("city-select");
    const districtSelect = document.getElementById("district-select");
    const wardSelect = document.getElementById("ward-select");

    districtSelect.disabled = true;
    wardSelect.disabled = true;

    citySelect.addEventListener("change", () => {
      const selectedCityId = citySelect.value;

      if (selectedCityId) {
        fetch(`/admin/districts_by_city?city_id=${selectedCityId}`)
          .then((response) => response.json())
          .then((data) => {
            districtSelect.innerHTML = '<option value="">Chọn quận</option>';
            wardSelect.innerHTML = '<option value="">Chọn phường</option>';

            data.forEach((district) => {
              districtSelect.insertAdjacentHTML(
                "beforeend",
                `<option value="${district.id}">${district.name}</option>`
              );
            });

            districtSelect.disabled = false;
          })
          .catch((error) => {
            console.error(error);
          });
      } 
      else {
        districtSelect.innerHTML = '<option value="">Chọn quận</option>';
        wardSelect.innerHTML = '<option value="">Chọn phường</option>';
        districtSelect.disabled = true;
        wardSelect.disabled = true;
      }
    });

    districtSelect.addEventListener("change", () => {
      const selectedDistrictId = districtSelect.value;

      if (selectedDistrictId) {
        fetch(`/admin/wards_by_district?district_id=${selectedDistrictId}`)
          .then((response) => response.json())
          .then((data) => {
            wardSelect.innerHTML = '<option value="">Chọn phường</option>';

            data.forEach((ward) => {
              wardSelect.insertAdjacentHTML(
                "beforeend",
                `<option value="${ward.id}">${ward.name}</option>`
              );
            });

            wardSelect.disabled = false;
          })
          .catch((error) => {
            console.error(error);
          });
      } 
      else {
        wardSelect.innerHTML = '<option value="">Chọn phường</option>';
        wardSelect.disabled = true;
      }
    });
  }
}
