class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @task = Task.new
    # linebot = LineService.new(ENV["LINE_ID"])
    # message_text = "Welcome to Task Chomp"
    # linebot.send_message(message_text)
  end

  def profile
    @user = current_user
  end


end
