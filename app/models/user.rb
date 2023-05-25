class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :notifications, as: :user
  has_many :tasks, dependent: :destroy
  has_many :chasks, through: :tasks

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Gamification methods
  # Event-driven points
  def break_down_bonus
    self.totalpoints += 10
    self.daypoints += 10
  end

  def complete_subchask_same_day_bonus
    # condition start date = date.today
    self.totalpoints += 5
    self.daypoints += 5
  end

  def complete_chask_same_day_bonus
    # condition start date = date.today
    self.totalpoints += 10
    self.daypoints += 10
  end

  def complete_subchask
    self.totalpoints += 15
    self.daypoints += 15
  end

  def complete_chask
    self.totalpoints += 30
    self.daypoints += 30
  end

  def start_chask
    self.totalpoints += 5
    self.daypoints += 5
  end

  def create_task
    self.totalpoints += 5
    self.daypoints += 5
  end

  def daily_login
    # need to add a condition that this can only happen once a day
    self.totalpoints += 10
    self.daypoints += 10
  end

  # Streak points - implement later
  # 	-bonus 10pts for every 3 consecutive days logged in
  # 	-bonus 30pts for 1 week streak, 90 for 2 week streak 180 for 1mth streak
  #   streak for x tasks completed throughout the day
end
