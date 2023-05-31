class TaskPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def create?
    true
  end

  def update?
    record.user == user
  end

  def deadline?
    true
  end

  def global_deadline?
    true
  end

  def destroy?
    true
  end

  def breakdown?
    # record.task.user == user
    true
  end

  def paused?
    true
  end

  def completed?
    true
  end

  def update?
    # record.task.user == user
    true
  end

  def excluded?
    true
  end

  def progress?
    true
  end

  def queued?
    true
  end

end
