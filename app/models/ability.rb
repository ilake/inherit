class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new  #guest user

    can :read, :all
    if user.is_not_guest?
      can :create, [Experience, Goal]
      can :update, [Experience, Goal, Profile] do |obj|
        obj.try(:user) == user
      end
      can :destroy, [Experience, Goal] do |obj|
        obj.try(:user) == user
      end

    end

  end
end

