$(document).ready(function() {
  var taxableIdField = $('#tax_code_taxable_id');
  var originalOptions = taxableIdField.html();

  taxableIdField.prop('disabled', true);

  $('#tax_code_taxable_type').on('change', function() {
    var selectedType = $(this).val();

    if (selectedType === '' || selectedType === 'Select Type') {
      taxableIdField.html(originalOptions).val('').prop('disabled', true);
    } 
    else {
      $.ajax({
        url: '/admin/tax_codes/' + selectedType.toLowerCase() + '_options',
        method: 'GET',
        dataType: 'json',
        success: function(data) {
          var options = '';

          if(data.length === 0){
            options = '<option value="">All have tax codes</option>';
          }
          else{
            $.each(data, function(index, item) {
              options += '<option value="' + item.id + '">' + '#'+ item.id + ' - ' + item.name + '</option>';
            });
          }
          taxableIdField.html(options).prop('disabled', false);
        },
        error: function(error) {
          console.log(error);
        }
      });
    }
  });
});
