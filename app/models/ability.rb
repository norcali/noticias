class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user
    if user.role? :admin
      can :manage, :all
    elsif user.role? :usuario
      can :index, Site
      can :show, Site
      can :agregar, Site
      can :manage, Post
    else
      can :read, :all
    end
  end
end