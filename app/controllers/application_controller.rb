class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :check_notifications
  include Pundit::Authorization

  # Pundit: allow-list approach
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # Uncomment when you *really understand* Pundit!
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # def user_not_authorized
  #   flash[:alert] = "You are not authorized to perform this action."
  #   redirect_to(root_path)
  # end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end

  def check_notifications
    if user_signed_in?
      @notifications = current_user.notifications.where(status: 'pending').map do |notification|
        notification.update(message: "Pending #{notification.chask.title} with #{current_user.email}")
        notification
      end
    end
  end
end
