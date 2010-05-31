// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function detect_end_at(){
  if ($('#experience_end_at_exist').attr('checked')) {
    $('#end_at_date select').attr('disabled', false);
    }
  else {
    $('#end_at_date select').attr('disabled', true);
  }
}

function detect_until_now(){
  if ($('#experience_until_now').attr('checked')) {
    $('#end_at_date select').attr('disabled', true);
    }
  else {
    $('#end_at_date select').attr('disabled', false);
  }
  $('#experience_end_at_exist').attr('checked', false);
}

$(document).ready(function(){
    detect_end_at();
    $('#experience_end_at_exist').change(function(){
      detect_end_at();
      $('#experience_until_now').attr('checked', false);
    });

    $('#experience_until_now').change(function(){
      detect_until_now();
    });
});
