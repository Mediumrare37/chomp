class Task < ApplicationRecord
  has_many :chasks
  belongs_to :user

  validates :title, presence: true
  # validates :completed, presence: true
end
