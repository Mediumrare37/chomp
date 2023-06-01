class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @task = Task.new
    linebot = LineService.new(ENV["LINE_ID"])
    message_text = "Task created"
    linebot.send_message(message_text)
  end


end
