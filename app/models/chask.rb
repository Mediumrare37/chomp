class Chask < ApplicationRecord
  STATUS = ['unrequested', 'pending', 'queued', 'progress', 'paused', 'completed', 'excluded']

  belongs_to :task
  belongs_to :chask, optional: true
  has_many :notifications, as: :object, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_many :chasks, dependent: :destroy


  validates :title, presence: true
  validates :status, presence: true

  def sub_chask?
    self.chask_id == true
  end

  def chask?
    self.chask_id == nil
  end

  def unrequested?
    self.status == 'unrequested'
  end

  def pending?
    self.status == 'pending'
  end

  def excluded?
    self.status == 'excluded'
  end

  def queued?
    self.status == 'queued'
  end

  def completed?
    self.status == 'completed'
  end

  def progress?
    self.status == 'progress'
  end

  def paused?
    self.status == 'paused'
  end

  def save_for_later
    self.status = 'queued'
  end

  def has_excluded_subchasks?
    # Use this method ONLY ON CHASKS
    Chask.where(chask_id: self.id).where(status: 'excluded') != []
  end

  def has_chasks?
    Chask.where(chask_id: self.id).where.not(status: 'unrequested') != []
  end

  def subchasks
    # Use this method ONLY ON CHASKS, returns all subchasks for a given chask
    Chask.where(chask_id: self.id).where.not(status: 'unrequested')
  end

  def parent_chask
    # Use this method ONLY on SUBCHASKS, returns parent chask for a given subchask
    Chask.find_by(id: self.chask_id)
  end

  def all_completed?
    # Use this method ONLY ON CHASKS
    all_subchasks = subchasks
    completed_subchasks = Chask.where(chask_id: self.id).where(status: 'completed')
    all_subchasks.length == completed_subchasks.length
  end

  after_save :update_task_completion_status

  def update_task_completion_status
    return unless task

    total_chasks = task.chasks.count
    completed_chasks = task.chasks.where(status: 'completed').count

    if total_chasks > 0 && completed_chasks == total_chasks
      task.update(completed: true)
    elsif completed_chasks < total_chasks && task.completed?
      task.update(completed: false)
    end
  end
end
