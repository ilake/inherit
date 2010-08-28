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
          $("#new_goal").submit(function(){  
            $(document).trigger('close.facebox');
            $('#action_comeplete_status').hide();
            $('#action_working_status').show();

            $.ajax({
              url: $(this).attr("action")+'.js',
              type: 'POST',
              data: $(this).serialize(),
              success: function(categories){
                $('#exp_categories').html(categories);
                $('#experience_goal_id').attr('value', $('#experience_goal_id option:last').attr('value'));
                $('#action_working_status').hide();
                $('#action_comeplete_status').show();
                }
              });
            return false;  
            });  

});
