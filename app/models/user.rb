class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :notifications, as: :user
  has_many :tasks
  has_many :chasks, through: :tasks

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
