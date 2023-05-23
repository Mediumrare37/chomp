class ChaskPolicy < ApplicationPolicy
  def index?
    true
  end

  def edit?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    record.task.user == user
  end

  def destroy?
    user == record.task.user
  end
end
