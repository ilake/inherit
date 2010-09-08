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

    $('#experience_data_number').change(function(){
        var href = [];
        href.push(location.pathname);
        href.push('?data_number='+$('#experience_data_number').val());
        var url = href.join('')
        window.location = url;
    });

    $('#profile_hide_show').click(function(){
        if( $('#user_content').attr('class') == 'show' ) {
          $('#profile_hide_show').removeClass('profile_show').addClass('profile_hide')
          $('#user_content').removeClass('show').addClass('hide')
        }
        else {
          $('#profile_hide_show').removeClass('profile_hide').addClass('profile_show')
          $('#user_content').removeClass('hide').addClass('show')
        }
    });

    $('.exp_list_cell').hover(
      function(){
        $(this).find('.exp-info').show();
        $(this).addClass('even');
        tl.getBand(0).scrollToCenter(
          new Date(
            $(this).find('.js_year').html(),
            $(this).find('.js_month').html(),
            $(this).find('.js_day').html()
          ));
        
      },
      function(){
        $(this).find('.exp-info').hide();
        $(this).removeClass('even');
      }
    );

    $('.time_line_point').click(function(){
        tl.getBand(0).scrollToCenter(new Date($(this).attr('value')));
    });

    $('#prev_position').click(function(){
        var current_position = $('#current_position').html();
        $('#exp_position_'+current_position).hide();
        if (current_position == '0' ) {
          current_position = $('#last_position').html();
        }
        else {
        current_position = current_position*1 - 1;
        }
        $('#exp_position_'+current_position).fadeIn();
        $('#current_position').html(current_position);
        var exp_pos = $('#exp_position_'+current_position);
        tl.getBand(0).scrollToCenter(
          new Date(
            exp_pos.find('.js_year').html(),
            exp_pos.find('.js_month').html(),
            exp_pos.find('.js_day').html()
          ));
    });

    $('#next_position').click(function(){
        var current_position = $('#current_position').html();
        $('#exp_position_'+current_position).hide();
        if (current_position == $('#last_position').html() ) {
          current_position = '0';
        }
        else {
          current_position = current_position*1 + 1;
        }
        $('#exp_position_'+current_position).fadeIn();
        $('#current_position').html(current_position);
        var exp_pos = $('#exp_position_'+current_position);

        tl.getBand(0).scrollToCenter(
          new Date(
            exp_pos.find('.js_year').html(),
            exp_pos.find('.js_month').html(),
            exp_pos.find('.js_day').html()
          ));
    });
});
