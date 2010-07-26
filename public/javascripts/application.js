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

function detect_user_date(){
  if ($('#user_date_check').attr('checked')) {
    $('#age_start_at').attr('disabled', false);
    $('#age_end_at').attr('disabled', false);
  }
  else {
    $('#age_start_at').attr('disabled', true);
    $('#age_end_at').attr('disabled', true);
  }
}
function detect_goal_category(){
  if ($('#goal_category').val() == 'category') {
    $('.goal_start_at select').attr('disabled', true);
    $('.goal_state select').attr('disabled', true);
  }
  else {
    $('.goal_start_at select').attr('disabled', false);
    $('.goal_state select').attr('disabled', false);
  }
}

function detect_goal_state(){
  if ($('#goal_state').val() == 'finish') {
    $('.goal_end_at select').attr('disabled', false);
  }
  else {
    $('.goal_end_at select').attr('disabled', true);
  }
}

$(document).ready(function(){
    $('a[rel*=facebox]').facebox();

    detect_user_date();

    detect_end_at();
    $('#experience_end_at_exist').change(function(){
      detect_end_at();
      $('#experience_until_now').attr('checked', false);
    });

    $('#experience_until_now').change(function(){
      detect_until_now();
    });

    $('#user_date_check').change(function(){
      detect_user_date();
    });

    $('#colorPicker').colorPicker();

    detect_goal_category();
    $('#goal_category').change(function(){
      detect_goal_category();
    });

    detect_goal_state();
    $('#goal_state').change(function(){
      detect_goal_state();
    });

    $('#experience_data_number').change(function(){
        var href = [];
        href.push(location.pathname);
        href.push('?data_number='+$('#experience_data_number').val());
        var url = href.join('')
        window.location = url;
    });
});
