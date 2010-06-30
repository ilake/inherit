var timeline_data = {  // save as a global variable
  'dateTimeFormat': 'iso8601',
  'events' : user_event
}

    var tl;
    function onLoad() {
        var tl_el = document.getElementById("exp_chart");
        var eventSource1 = new Timeline.DefaultEventSource();
        
        var theme1 = Timeline.ClassicTheme.create();
        theme1.event.bubble.width = 350;   // modify it
        theme1.event.bubble.height = 300;
        theme1.event.track.height = 15;
        theme1.event.tape.height = 10;

        theme1.timeline_start = timeline_start_at;
        var t = new Date();
        var year = t.getFullYear();
        theme1.timeline_stop  = new Date(year+5, 12, 31);
        
  // 置中
        var d = Timeline.DateTime.parseGregorianDateTime(timeline_default_at);
        var bandInfos = [
            Timeline.createBandInfo({
                width:          "80%", // set to a minimum, autoWidth will then adjust
                intervalUnit:   Timeline.DateTime.MONTH, 
                intervalPixels: 150,
                eventSource:    eventSource1,
                date:           d,
                theme:          theme1,
                timeZone:       8,
                layout:         'original'  // original, overview, detailed
            }),
            Timeline.createBandInfo({
                width:          "20%", // set to a minimum, autoWidth will then adjust
                intervalUnit:   Timeline.DateTime.YEAR, 
                intervalPixels: 100,
                eventSource:    eventSource1,
                date:           d,
                theme:          theme1,
                timeZone:       8,
                layout:         'overview'  // original, overview, detailed
            })
        ];
  
  bandInfos[1].syncWith = 0;
  bandInfos[1].highlight = true;
                                                        
        // create the Timeline
        tl = Timeline.create(tl_el, bandInfos, Timeline.HORIZONTAL);
        
        var url = '.'; // The base url for image, icon and background image
                       // references in the data
        eventSource1.loadJSON(timeline_data, url); // The data was stored into the 
                                                   // timeline_data variable.
        tl.layout(); // display the Timeline
    }

    var resizeTimerID = null;
    function onResize() {
      if (resizeTimerID == null) {
        resizeTimerID = window.setTimeout(function() {
            resizeTimerID = null;
            tl.layout();
            }, 500);
      }
    }

    $(document).ready(function(){
      onLoad();
    });

    $(document).resize(function() {
      onResize();
    });

        
