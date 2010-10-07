
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

    $('.advance-content').hide();
    $('.advance-content textarea').attr('disabled', true);

    $('span.advance').click(
      function(){
        $('.normal').show();
        $('.advance').hide();
        $('.normal-content').hide();
        $('.advance-content').show();
        $('#experience_content_tbl').height('400px').width('550px');
        $('#experience_content_ifr').height('350px');
        $('.normal-content textarea').attr('disabled', true);
        $('.advance-content textarea').attr('disabled', false);
      }
    );

    $('span.normal').click(
      function(){
        $('.advance').show();
        $('.normal').hide();
        $('.normal-content').show();
        $('.advance-content').hide();
        $('.advance-content textarea').attr('disabled', true);
        $('.normal-content textarea').attr('disabled', false);
      }
    );

//    tinymce.dom.Event.add(document.getElementById("experience_content_ifr"), 'keyup', function(e) {
//      alert(e.target);
//    });
//    tinymce.dom.Event.add(tinyMCE.get('experience_content').getDoc(), 'keyup', function(e) {
//      alert(e.target);
//    });
//    tinyMCE.addEvent(tinyMCE.getInstanceById('experience_content'), 'keydown',alert('keydown'));

    $('#user_date_check').change(function(){
      detect_user_date();
    });

    $('#experience_data_number').change(function(){
        var href = [];
        href.push(location.pathname);
        href.push('?data_number='+$('#experience_data_number').val());
        var url = href.join('')
        window.location = url;
    });

    $('.exp_list_cell').hover(
      function(){
        $(this).find('.exp-info').show();
        $(this).addClass('even');
      },
      function(){
        $(this).find('.exp-info').hide();
        $(this).removeClass('even');
      }
    );

    $('.goal_list_cell').hover(
      function(){
        $(this).find('.goal-info').show();
        $(this).addClass('even');
      },
      function(){
        $(this).find('.goal-info').hide();
        $(this).removeClass('even');
      }
    );

    $('.share_link').click(function(){

      var current_exp = $(this).parent().parent();
      current_exp.find('.share_ajax_loading').show();
      $.ajax({
        url: $(this).attr('href'),
        type: 'GET',
        data: '',
        dataType:  'html',
        success: function(html){
          current_exp.find('.share-link-partial').html(html);
          current_exp.find('.share_ajax_loading').hide();
        },
        error: function(){
          alert('Fail');
          current_exp.find('.share_ajax_loading').hide();
        }
      });
      return false;
    }); 
});
