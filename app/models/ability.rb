class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new  #guest user

    can :read, :all
    if user.is_not_guest?
      can :create, Experience
      can :update, Experience do |experience|
        experience.try(:user) == user
      end
      can :destroy, Experience do |experience|
        experience.try(:user) == user
      end

      can :create, Goal
      can :update, Goal do |goal|
        goal.try(:user) == user
      end
      can :destroy, Goal do |goal|
        goal.try(:user) == user
      end

    end

  end
end

