class NotificationsController < ApplicationController
  def index
    @notifications = policy_scope(current_user.notifications)
    @notifications.update_all(read: true)
  end
end
