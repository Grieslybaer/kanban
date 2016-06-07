class Ability
  include CanCan::Ability

  def initialize(user)

    can :manage, User, id: user.id
    
    # abilities for project
    can :manage, Project, owners: { id: user.id }
    can :read, Project, users: { id: user.id }

    # abilities for members
    can :manage, Member, project: { owners: { id: user.id } }
    can :read, Member, project: { users: { id: user.id } }

    # abilities for assignments (project task user)
    can :manage, Assignment, project: { owners: { id: user.id } }
    can :update, Assignment, user_id: user.id

    # abilities for tasks
    can :manage, Task, project: { owners: { id: user.id } }
    can :read, Task, project: { users: { id: user.id } }
  end
end
