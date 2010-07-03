module TagListFunc
  def self.included(base)
      base.before_save :set_tags_list
      base.before_create :default_set_user_location if base != Profile
      base.send(:extend, ClassMethods)
      base.send(:include, InstanceMethods)
  end

  module ClassMethods
    def location_with(location)
      if location == 'World' || location.blank?
        scope = self.scoped#({:include => :user})
      else
        tagged_with(location, :on => :locations)
      end
    end
  end

  module InstanceMethods
    private
    def set_tags_list
      self.tags_list = tag_list.join(" ")
    end

    def default_set_user_location
      self.location_list = self.user.location_list
    end

  end
end
