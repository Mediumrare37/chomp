class Chask < ApplicationRecord
  STATUS = ['pending', 'queued', 'progress', 'paused', 'completed', 'excluded']

  belongs_to :task
  belongs_to :chask, optional: true
  has_many :chasks, dependent: :destroy
  has_many :notifications, as: :object, dependent: :destroy

  validates :title, presence: true
  validates :status, presence: true

  def show_inner_chasks
    # method
  end

  def pending?
    self.status == 'pending'
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
