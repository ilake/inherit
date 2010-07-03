# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
# weekly
every 1.hour do
  rake "thinking_sphinx:index"
end

every :sunday, :at => '3 am' do
  rake "notify:goal_empty"
end

every :sunday, :at => '4 am' do
  rake "notify:exp_empty"
end

#every 1.day, :at => '5:00 am' do
#    rake "-s sitemap:refresh"
#end

every :sunday, :at => '6 am' do
  rake "cache:clear"
end

every :reboot do
  rake "thinking_sphinx:start"
end

