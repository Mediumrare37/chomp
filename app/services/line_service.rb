require "json"
require 'line/bot'

class LineService
  def initialize(id)
    @id = id
  end

  # def client
  #   p ENV['LINE_SECRET'], ENV['LINE_TOKEN']
  #   p @client ||= Line::Bot::Client.new { |config|
  #     config.channel_secret = ENV['LINE_SECRET']
  #     config.channel_token = ENV['LINE_TOKEN']
  #   }
  # end

  def send_message(text)
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_SECRET"]
      config.channel_token = ENV["LINE_TOKEN"]
    }

    text = "plz fking work"

    message = {
      type: 'text',
      text: text
    }
    p @client.push_message("55327ce05d1c61796906cac4b3573aa3", message)
    # message = {
    #   type: 'text',
    #   text: text
    # }
    # p message
    # p @id

    # p client.push_message(@id, message)
  end


end
