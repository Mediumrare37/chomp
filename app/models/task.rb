class Task < ApplicationRecord
  has_many :chasks
  belongs_to :user
  has_many :notifications, as: :object
  validates :title, presence: true
  # validates :completed, presence: true
end
