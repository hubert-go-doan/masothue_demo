import { Controller } from "@hotwired/stimulus"
import * as Routes from '../routes';

export default class extends Controller {
  connect() {
    console.log('connect!');
    this.disableSelectFields();
  }

  disableSelectFields() {
    const citySelect = $('#city-select');
    const districtSelect = $('#district-select');
    const wardSelect = $('#ward-select');
    districtSelect.prop('disabled', true);
    wardSelect.prop('disabled', true);

    citySelect.on('change', () => {
      const selectedCityId = citySelect.val();
      
      if (selectedCityId) {
        $.get(Routes.admin_districts_by_city_path({city_id: selectedCityId}))
          .done((data) => {
            console.log(data);
            districtSelect.html('<option value="">Chọn quận</option>');

            wardSelect.html('<option value="">Chọn phường</option>');

            $.each(data, (index, district) => {
              districtSelect.append(`<option value="${district.id}">${district.name}</option>`);
            });

            districtSelect.prop('disabled', false);
          })
          .fail((error) => {
            console.error(error);
          });
      } 
      else {
        districtSelect.html('<option value="">Chọn quận</option>');
        wardSelect.html('<option value="">Chọn phường</option>');
        districtSelect.prop('disabled', true);
        wardSelect.prop('disabled', true);
      }
    });

    districtSelect.on('change', () => {
      const selectedDistrictId = districtSelect.val();

      if (selectedDistrictId) {
        $.get(Routes.admin_wards_by_district_path({district_id: selectedDistrictId}))
          .done((data) => {
            wardSelect.html('<option value="">Chọn phường</option>');

            $.each(data, (index, ward) => {
              wardSelect.append(`<option value="${ward.id}">${ward.name}</option>`);
            });

            wardSelect.prop('disabled', false);
          })
          .fail((error) => {
            console.error(error);
          });
      } 
      else {
        wardSelect.html('<option value="">Chọn phường</option>');
        wardSelect.prop('disabled', true);
      }
    });
  }
}
