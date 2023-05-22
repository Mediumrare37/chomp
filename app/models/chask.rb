class Chask < ApplicationRecord
  belongs_to :task
  belongs_to :chask, optional: true

  validates :title, presence: true
  validates :status, presence: true
end
