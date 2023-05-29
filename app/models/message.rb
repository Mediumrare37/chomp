class Message < ApplicationRecord
  belongs_to :chask
  belongs_to :user

  def sender?(a_user)
    user.id == a_user.id
  end
end
