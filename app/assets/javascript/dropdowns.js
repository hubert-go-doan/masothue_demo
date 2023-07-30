document.addEventListener('DOMContentLoaded', function() {
  const citySelect = document.getElementById('city-select');
  const districtSelect = document.getElementById('district-select');
  const wardSelect = document.getElementById('ward-select');

  citySelect.addEventListener('change', function() {
    const selectedCityId = this.value;
    if (selectedCityId) {
      fetch(`/admin/districts_by_city?city_id=${selectedCityId}`)
        .then(response => response.json())
        .then(data => {
          districtSelect.innerHTML = '<option value="">Chọn quận</option>';
          wardSelect.innerHTML = '<option value="">Chọn phường</option>';
          data.forEach(district => {
            districtSelect.innerHTML += `<option value="${district.id}">${district.name}</option>`;
          });   
        });
    } 
    else {
      districtSelect.innerHTML = '<option value="">Chọn quận</option>';
      wardSelect.innerHTML = '<option value="">Chọn phường</option>';
    }
  });

  districtSelect.addEventListener('change', function() {
    const selectedDistrictId = this.value;
    if (selectedDistrictId) {
      fetch(`/admin/wards_by_district?district_id=${selectedDistrictId}`)
        .then(response => response.json())
        .then(data => {
          wardSelect.innerHTML = '<option value="">Chọn phường</option>';
          data.forEach(ward => {
            wardSelect.innerHTML += `<option value="${ward.id}">${ward.name}</option>`;
          });
        });
    } 
    else {
      wardSelect.innerHTML = '<option value="">Chọn phường</option>';
    }
  });
});
