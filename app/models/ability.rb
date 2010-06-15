class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new  #guest user
    if user.admin?
      can :manage, :all
    else

      can :read, :all
      if user.is_not_guest?
        can :create, [Experience, Goal, Question, Chat]
        can :update, [Experience, Goal, Profile, Question] do |obj|
          obj.try(:user) == user
        end
        can :destroy, [Experience, Goal, Question, Chat] do |obj|
          obj.try(:user) == user
        end
      end

    end

  end
end

