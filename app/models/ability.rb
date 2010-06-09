class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new  #guest user

    can :read, :all
    if user.is_not_guest?
      can :create, [Experience, Goal, Question]
      can :update, [Experience, Goal, Profile, Question] do |obj|
        obj.try(:user) == user
      end
      can :destroy, [Experience, Goal, Question] do |obj|
        obj.try(:user) == user
      end

    end

  end
end

