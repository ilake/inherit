namespace :notify do
  desc 'Sunday: no goal mail notification'
  task :goal_empty => :environment do
    User.find_in_batches do |users|
        users.each { |user|
          NotificationMailer.send_later(:deliver_goal_empty, user)  if user.goals.count.zero?
        }
    end
  end

  #是不是要根據goal 來寄勒, 先不要, 先給有目標卻一個禮拜都沒經驗紀錄的
  desc 'Sunday: goal no experience notification'
  task :exp_empty => :environment do
    User.find_in_batches do |users|
        users.each { |user|
          NotificationMailer.send_later(:deliver_exp_empty, user, user.goals.map{|g| g.title}, user.fans_count)  if !user.goals.count.zero? && user.experiences.is_belong_one_goal.this_week.count.zero?
        }
    end
  end
end
