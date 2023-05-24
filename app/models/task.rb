class Task < ApplicationRecord
  has_many :chasks, dependent: :destroy
  belongs_to :user
  has_many :notifications, as: :object
  validates :title, presence: true
  # validates :completed, presence: true
end
