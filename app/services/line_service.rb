require "json"
require 'line/bot'

class LineService
  def initialize(id)
    @id = id
  end

  def client
    p ENV['LINE_SECRET'], ENV['LINE_TOKEN']
    p @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV['LINE_SECRET']
      config.channel_token = ENV['LINE_TOKEN']
    }
  end

  def send_message(text)
    message = {
      type: 'text',
      text: text
    }
    client.push_message(@id, message)
  end
end
