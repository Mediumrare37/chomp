class Chask < ApplicationRecord
  STATUS = ['pending', 'queued', 'progress', 'paused', 'completed', 'excluded']

  belongs_to :task
  belongs_to :chask, optional: true
  has_many :notifications, as: :object

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
end
