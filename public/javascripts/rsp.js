// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

var parsing = null;
var content = null;
var parse_done = false;

function trigger_parse(){
var url = content.match(/\b((https?|ftp|file):\/\/|www\.|ftp\.)[-A-Z0-9+&@#\/%=~_|$?!:,.]*[A-Z0-9+&@#\/%=~_|$]/gi);

  if (url) {
    $('#ajax_loading').show();

    $.ajax({
      url: '/url',
      type: 'GET',
      data: 'url='+url[0],
      dataType:  'html',
      success: function(html){
        parse_done = true;
        $('#url_title_desc').html(html);
        $('#ajax_loading').hide();
      },
      error: function(){
        alert('Fail');
        $('#ajax_loading').hide();
      }
    });
  }
}

$(document).ready(function(){

    $('.normal-content #experience_content').keyup(function(){
      if(!parse_done) {
        content = $(this).attr('value');

        if (parsing !== null) {
        clearTimeout(parsing);
        parsing = null;
        }
        parsing = setTimeout("trigger_parse()", 1000);
      }
    });

    $('.normal-content #experience_content').mouseup(function(){
      if(!parse_done) {
        content = $(this).attr('value');

        if (parsing !== null) {
          clearTimeout(parsing);
          parsing = null;
        }
        parsing = setTimeout("trigger_parse();", 1000);
      }
    });

});
