//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require dropdowns
//= require bootstrap-datepicker
//= require bootstrap-datepicker/locales/bootstrap-datepicker.es.js
//= jquery_ujs

$(document).ready(function() {
  $('.datepicker').datepicker({
    format: 'dd/mm/yyyy', 
    autoclose: true 
  });
});
