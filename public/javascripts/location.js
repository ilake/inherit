function change_location_func(val) {
    $.ajax({
      url: '/change_user_location',
      type: 'POST',
      data: ({user_location : val}),
      async:false,
      success: function(){
        $('#user_location').html(val);
      }
    });
}

$(document).ready(function(){
    $('#user_location_list').change(function(){
      var val = $(this).val();
      change_location_func(val);
      location.reload();
      });

    $('.change_location').click(function() {
      var val = $(this).attr('value');
      change_location_func(val);
      location.reload();
      return false;
      });
});
