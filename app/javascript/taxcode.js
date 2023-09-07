import * as Routes from './routes';

$(document).on('turbo:load', () => {
  const taxableIdField = $('#tax-code-taxable-id');
  const originalOptions = taxableIdField.html();
  taxableIdField.prop('disabled', true);

  $('#tax-code-taxable-type').on('change', ({ target }) => {
    const selectedType = target.value;
    if (selectedType === '' || selectedType === 'Select Type') {
      taxableIdField.html(originalOptions).val('').prop('disabled', true);
    } 
    else {
      let getTaxCodesUrl;
      if (selectedType === 'Company') {
        getTaxCodesUrl = Routes.company_options_admin_tax_codes_path();
      } 
      else if (selectedType === 'Person') {
        getTaxCodesUrl = Routes.person_options_admin_tax_codes_path();
      }
      $.ajax({
        url: getTaxCodesUrl,
        method: 'GET',
        dataType: 'json',
        success: (data) => {
          let options = '';

          if (data.length === 0) {
            options = '<option value="">All have tax codes</option>';
          } 
          else {
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
