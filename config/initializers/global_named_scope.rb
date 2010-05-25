class ActiveRecord::Base
  named_scope :limit, lambda { |num| {:limit => num} }
end
