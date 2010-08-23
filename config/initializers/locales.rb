LOCALES_DIRECTORY = "#{RAILS_ROOT}/config/locales"
LOCALES_AVAILABLE = Dir["#{LOCALES_DIRECTORY}/*.{rb,yml}"].delete_if{|d| d.match(/(devise)/)}.collect do |locale_file|
  I18n.load_path << locale_file
  File.basename(File.basename(locale_file, ".rb"), ".yml")
end
