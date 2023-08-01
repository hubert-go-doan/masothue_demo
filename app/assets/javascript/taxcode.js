$(document).ready(() => {
  const taxableIdField = $('#tax-code-taxable-id');
  const originalOptions = taxableIdField.html();

  taxableIdField.prop('disabled', true);

  $('#tax-code-taxable-type').on('change', ({ target }) => {
    const selectedType = target.value;

    if (selectedType === '' || selectedType === 'Select Type') {
      taxableIdField.html(originalOptions).val('').prop('disabled', true);
    } else {
      $.ajax({
        url: '/admin/tax_codes/' + selectedType.toLowerCase() + '_options',
        method: 'GET',
        dataType: 'json',
        success: (data) => {
          let options = '';

          if (data.length === 0) {
            options = '<option value="">All have tax codes</option>';
          } else {
            data.forEach((item) => {
              options += `<option value="${item.id}">#${item.id} - ${item.name}</option>`;
            });
          }
          taxableIdField.html(options).prop('disabled', false);
        },
        error: (error) => {
          console.log(error);
        }
      });
    }
  });
});