class Ability
  include CanCan::Ability

  # def initialize(user)
  #   user ||= User.new # guest user (not logged in)
  #   can :read, [User, Article, Comment]

  #   if user.has_role? :admin
  #     can :manage, :all
  #   # elsif user.has_role? :teacher
  #   #   can :create, Comment
  #   #   can :read, [Tiding, User, Test, TestSetting]
  #   #   can :manage, [TestSetting, MethodicalWork], user_id: user.id
  #   # elsif user.has_role? :student
  #   #   can :create, Comment
  #   #   can :read, [Tiding, User, MethodicalWork]
  #   else
  #     can :create, Comment
  #     can :read, [Tiding, User, MethodicalWork]
  #   end
  # end


  def initialize(user)
    # Guest User
    unless user
      can :read, [User, Article, Comment]
      can :create, User
    else
      # All registered users
      can :read, :all
      can :manage, [Article, Comment], user_id: user.id
      # Admins
      if user.has_role? :admin
        can :manage, :all
      end
    end
  end

end
