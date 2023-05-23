class ChaskPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    user == record.task.user
  end

  def destroy?
    user == record.task.user
  end
end
