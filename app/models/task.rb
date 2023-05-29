class Task < ApplicationRecord
  has_many :chasks, dependent: :destroy
  belongs_to :user
  has_many :notifications, as: :object
  validates :title, presence: true
  # validates :completed, presence: true

  def complete_percentage
    if chasks.where(status: "completed").any?
      (chasks.where(status: "completed").length / chasks.length.to_f * 100).round
    else
      0
    end
  end
end
