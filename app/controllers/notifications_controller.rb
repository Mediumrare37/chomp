# require 'httparty'

# class NotificationsController < ApplicationController

#   def index
#     @notifications = policy_scope(current_user.notifications)
#     @notifications.update_all(read: true)
#   end

#   def send_notification
#     channel_access_token = "ZGdMT28oxK96w4NTDcH9fKBgMhKRl73s3BbbYiJrpGZl38sY8jkwArT30/Y3S4O3Q3bAUtIimEYXAMSIvxbRyYorHflMKr9JwBsVzhni4ioZWKJcWg8YW3gE+On7l72WZzUMHwbj/Jv5UsqErOy9QAdB04t89/1O/w1cDnyilFU="
#     user_id = "johntaskchompline"

#     message = {
#       type: "text",
#       text: "Hello, this is a notification from TaskChomp!"
#     }

#     response = HTTParty.post(
#       "https://api.line.me/v2/bot/message/push",
#       headers: {
#         "Content-Type" => "application/json",
#         "Authorization" => "Bearer #{channel_access_token}"
#       },
#       body: {
#         to: user_id,
#         messages: [message]
#       }.to_json
#     )

#     if response.code == 200
#       # Notification sent successfully
#       # Handle success response
#       puts "Notification sent successfully"
#     else
#       # Failed to send notification
#       # Handle error response
#       puts "Failed to send notification"
#     end
#   end
# end
