$(document).ready(function() {
  const citySelect = $('#city-select');
  const districtSelect = $('#district-select');
  const wardSelect = $('#ward-select');

  citySelect.on('change', function() {
    const selectedCityId = $(this).val();
    if (selectedCityId) {
      $.get(`/admin/districts_by_city?city_id=${selectedCityId}`)
        .done(function(data) {
          districtSelect.html('<option value="">Chọn quận</option>');
          wardSelect.html('<option value="">Chọn phường</option>');
          data.forEach(function(district) {
            districtSelect.append(`<option value="${district.id}">${district.name}</option>`);
          });
        });
    } else {
      districtSelect.html('<option value="">Chọn quận</option>');
      wardSelect.html('<option value="">Chọn phường</option>');
    }
  });

  districtSelect.on('change', function() {
    const selectedDistrictId = $(this).val();
    if (selectedDistrictId) {
      $.get(`/admin/wards_by_district?district_id=${selectedDistrictId}`)
        .done(function(data) {
          wardSelect.html('<option value="">Chọn phường</option>');
          data.forEach(function(ward) {
            wardSelect.append(`<option value="${ward.id}">${ward.name}</option>`);
          });
        });
    } else {
      wardSelect.html('<option value="">Chọn phường</option>');
    }
  });
});
