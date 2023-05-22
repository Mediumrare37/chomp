class Chask < ApplicationRecord
  belongs_to :task
  has_manu :sub_chasks

  validates :title, presence: true
  validates :status, presence: true
end
