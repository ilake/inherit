namespace :cache do
  desc 'Sunday clear tmp/cache'
  task :clear => :environment do
    `rm -rf #{Rails.root}/tmp/cache/*`
  end
end
