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

  def deadline?
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

  def progress?
    true
  end

  def update?
    # record.task.user == user
    true
  end

  def excluded?
    true
  end

  def queued?
    true
  end

  def destroy?
    user == record.task.user
  end
end
