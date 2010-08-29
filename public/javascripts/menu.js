$("#home_sidebar .menu > li:not(#goalmore)").click(function(e){
    switch(e.target.id){
      case "working":
        //change status &amp;amp;amp; style menu
        $("#working").addClass("active");
        $("#help").removeClass("active");
        $("#finish").removeClass("active");
        //display selected division, hide others
        $("div.working").show();
        $("div.help").css("display", "none");
        $("div.finish").css("display", "none");
      break;
      case "help":
        //change status &amp;amp;amp; style menu
        $("#working").removeClass("active");
        $("#help").addClass("active");
        $("#finish").removeClass("active");
        //display selected division, hide others
        $("div.help").show();
        $("div.working").css("display", "none");
        $("div.finish").css("display", "none");
      break;
      case "finish":
        //change status &amp;amp;amp; style menu
        $("#working").removeClass("active");
        $("#help").removeClass("active");
        $("#finish").addClass("active");
        //display selected division, hide others
        $("div.finish").show();
        $("div.working").css("display", "none");
        $("div.help").css("display", "none");
      break;
    }
    //alert(e.target.id);
    return false;
  });
