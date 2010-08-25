ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.merge!( 
  :fulltime => "%Y-%m-%d %H:%M:%S",
  :time => "%my%d  %H:%M",
  :hm => "%H:%M",
  :date => "%Y-%m-%d",
  :ym => '%Y/%m',
  :js_date => '%Y, %m, %d',
  :md => "%m-%d"
)     
