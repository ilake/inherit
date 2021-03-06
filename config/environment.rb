# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Specify gems that this application depends on and have them installed with rake gems:install
  # config.gem "bj"
  # config.gem "sqlite3-ruby", :lib => "sqlite3"
  # config.gem "aws-s3", :lib => "aws/s3"
  config.gem "mislav-will_paginate", :lib => "will_paginate", :source => "http://gems.github.com"
  #config.gem 'devise', :version => '1.0.7'
  config.gem 'cancan'
  config.gem "acts-as-taggable-on", :source => "http://gemcutter.org", :version => '2.0.0.rc1'
  config.gem 'hoptoad_notifier'
  config.gem 'sanitize'
  config.gem 'riddle'
  #config.gem 'thinking-sphinx', :lib => 'thinking_sphinx', :version => '1.3.16'
  config.gem 'ts-delayed-delta', :lib => 'thinking_sphinx/deltas/delayed_delta', :version => '>= 1.0.0', :source => 'http://gemcutter.org'
  config.gem 'chronic'
  config.gem 'whenever', :lib => false, :source => 'http://rubygems.org'
  config.gem 'daemons'
  config.gem 'geoip'
  config.gem 'sitemap_generator', :lib => false
  config.gem 'devise_facebook_connectable'
  config.gem 'facebooker'
  config.gem 'contacts'
  config.gem 'hpricot', :source => 'http://rubygems.org'
  #config.gem 'mime-types', :lib => 'mime-types'
  #config.gem 'http_accept_language'
  #config.gem 'ryanb-acts-as-list', :lib => 'acts_as_list', :source => 'http://gems.github.com'


  # Only load the plugins named here, in the order given (default is alphabetical).
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Skip frameworks you're not going to use. To use Rails without a database,
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names.
  config.time_zone = 'UTC'

  # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
  # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
  config.i18n.default_locale = :en
  config.action_controller.page_cache_directory = RAILS_ROOT + '/public/cache/'
  config.cache_store = :file_store, File.join(RAILS_ROOT, 'public', 'action_cache')
end

ENV['TZ'] = 'UTC'

begin
  #CacheStore = Moneta::Memcache.new(:server => "127.0.0.1")
  CacheStore = Moneta::BasicFile.new(:path => "tmp/cache")
rescue
  CacheStore = Moneta::BasicFile.new(:path => "tmp/cache")
end

SHARE_URL_SALT= "mw6eiqrdwtjzn4bt5pkdi46jw3n2nrpnr3qhkjnhidwbenq7e5eajwk6cmpfpd83a65w8mj96hzhtf2z5it5w9ja8wpm5rke36jnqi7qb8waqkrarqzib7m3jfcn7mkb"
