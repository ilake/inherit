    $(document).ready(function(){
      $("#new_goal").submit(function(){  
        $(document).trigger('close.facebox');
        $('#action_comeplete_status').hide();
        $('#action_working_status').show();

        $.ajax({
          url: $(this).attr("action"),
          type: 'POST',
          data: $(this).serialize(),
          dataType: 'json',
          success: function(categories){
            if (categories.SUCCESS) {
              alert(categories.MESSAGE);
              $('#exp_categories').html(categories.SUCCESS);
              $('#experience_goal_id').attr('value', $('#experience_goal_id option:last').attr('value'));
              $('#action_working_status').hide();
              $('#action_fail_status').hide();
              $('#action_comeplete_status').show();
            }
            else {
              alert(categories.FAIL);
              $('#action_comeplete_status').hide();
              $('#action_working_status').hide();
              $('#action_fail_status').show();
            }
          }
        });
        return false;  
      });  
    });
