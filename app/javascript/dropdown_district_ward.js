$(document).on('turbo:load', () => {
  const citySelect = $('#city-select');
  const districtSelect = $('#district-select');
  const wardSelect = $('#ward-select');

  citySelect.on('change', () => {
    const selectedCityId = citySelect.val();
    if (selectedCityId) {
      $.get(`/admin/districts_by_city?city_id=${selectedCityId}`)
        .done(data => {
          districtSelect.html('<option value="">Chọn quận</option>');
          wardSelect.html('<option value="">Chọn phường</option>');
          data.forEach(district => {
            districtSelect.append(`<option value="${district.id}">${district.name}</option>`);
          });
        });
    } else {
      districtSelect.html('<option value="">Chọn quận</option>');
      wardSelect.html('<option value="">Chọn phường</option>');
    }
  });

  districtSelect.on('change', () => {
    const selectedDistrictId = districtSelect.val();
    if (selectedDistrictId) {
      $.get(`/admin/wards_by_district?district_id=${selectedDistrictId}`)
        .done(data => {
          wardSelect.html('<option value="">Chọn phường</option>');
          data.forEach(ward => {
            wardSelect.append(`<option value="${ward.id}">${ward.name}</option>`);
          });
        });
    } else {
      wardSelect.html('<option value="">Chọn phường</option>');
    }
  });
});
