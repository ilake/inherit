namespace :notify do
  desc 'Sunday: no goal mail notification'
  task :goal_empty => :environment do
    User.find_in_batches do |users|
        users.each { |user|
          user.deliver_goal_empty_notification if user.email && user.goals.not_category.count.zero?
        }
    end
  end

  #是不是要根據goal 來寄勒, 先不要, 先給有目標或分類卻一個禮拜都沒經驗紀錄的
  desc 'Sunday: goal no experience notification'
  task :exp_empty => :environment do
    User.find_in_batches do |users|
        users.each { |user|
          user.deliver_exp_empty_notification if user.email && !user.goals.not_category.count.zero? && user.experiences.is_belong_one_goal.this_week.count.zero?
        }
    end
  end
end
