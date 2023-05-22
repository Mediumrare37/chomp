class SubChask < ApplicationRecord
  belongs_to :chask

  validates :title, presence: true
  validates :status, presence: true
end
