class ActiveRecord::Base
  named_scope :limit, lambda { |num| {:limit => num} }

  named_scope :show_policy, Proc.new{|is_owner|
    if !is_owner 
      {:conditions => {:public => true}}
    end
  }
end
