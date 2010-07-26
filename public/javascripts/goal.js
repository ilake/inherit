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
    detect_goal_category();
    $('#goal_category').change(function(){
      detect_goal_category();
    });

    detect_goal_state();
    $('#goal_state').change(function(){
      detect_goal_state();
    });

});
