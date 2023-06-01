# require 'line/bot'

# Rails.application.config.middleware.use(
#   Line::Bot::Middleware,
#   channel_secret: 'YOUR_CHANNEL_SECRET',
#   channel_token: 'YOUR_CHANNEL_ACCESS_TOKEN'
# )
# Replace 'YOUR_CHANNEL_SECRET' and 'YOUR_CHANNEL_ACCESS_TOKEN' with your actual credentials.

# Create a new file called line_notification.rb in the lib directory with the following content:

# ruby
# Copy code
# require 'line/bot'

# class LineNotification
#   def self.send_notification(user_id, message)
#     client = Line::Bot::Client.new { |config|
#       config.channel_secret = Rails.application.credentials.line[:channel_secret]
#       config.channel_token = Rails.application.credentials.line[:channel_access_token]
#     }

#     message = {
#       type: 'text',
#       text: message
#     }

#     client.push_message(user_id, message)
#   end
# end
