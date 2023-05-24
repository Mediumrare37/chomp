class Task < ApplicationRecord
  has_many :chasks, dependent: :destroy
  belongs_to :user

  validates :title, presence: true
  # validates :completed, presence: true
end
