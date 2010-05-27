
module ApplicationConfiguration
  require 'ostruct'
  ::AppConfig = OpenStruct.new
end

AppConfig.simple_mce_options = {
                    :theme => 'advanced',
                    :browsers => %w{msie gecko safari},
                    :cleanup_on_startup => true,
                    :convert_fonts_to_spans => true,
                    :theme_advanced_resizing => true, 
                    :theme_advanced_toolbar_location => "top",  
                    :theme_advanced_statusbar_location => "bottom", 
                    :editor_deselector => "mceNoEditor",
                    :theme_advanced_resize_horizontal => false,  
                    :theme_advanced_buttons1 => %w{underline link unlink image separator },
                    :theme_advanced_buttons2 => [],
                    :theme_advanced_buttons3 => []
                }

AppConfig.adv_mce_options = {
                    :theme => 'advanced',
                    :browsers => %w{msie gecko safari},
                    :cleanup_on_startup => true,
                    :convert_fonts_to_spans => true,
                    :theme_advanced_resizing => true, 
                    :theme_advanced_toolbar_location => "top",  
                    :theme_advanced_statusbar_location => "bottom", 
                    :editor_deselector => "mceNoEditor",
                    :theme_advanced_resize_horizontal => false,  
                    :theme_advanced_buttons1 => %w{formatselect fontsizeselect bold italic underline separator bullist numlist separator link unlink image separator help},
                    :theme_advanced_buttons2 => [],
                    :theme_advanced_buttons3 => []
                }
