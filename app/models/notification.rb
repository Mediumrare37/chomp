class Notification < ApplicationRecord
  belongs_to :user, polymorphic: true
  belongs_to :object, polymorphic: true
  validates_uniqueness_of :object_id, conditions: -> { where("DATE(created_at) = ?", Date.today) }
end
