class Message < ApplicationRecord
  belongs_to :chask
  belongs_to :user

  def sender?(a_user)
    user == a_user
  end
end
