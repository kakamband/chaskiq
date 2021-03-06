class AppPolicy < ActionPolicy::Base
  def index?
    # allow everyone to perform "index" activity on posts
    true
  end


  def show?
    record.owner_id == user.id || record.roles.where(
      agent_id: user.id
    ).any?
  end

  def invite_user?
    record.owner_id == user.id || record.roles.where(
      agent_id: user.id
    ).tagged_with("manage").any?
  end

  def create_app?
    user.can_create_apps?
  end

  def manage?
    record.owner_id == user.id || record.roles.where(
      agent_id: user.id
    ).tagged_with("manage").any?
  end

  def update?
    # here we can access our context and record
    user.admin? || (user.id == record.user_id)
  end
end