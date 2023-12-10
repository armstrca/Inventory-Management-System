class ApplicationController < ActionController::Base
  include Pundit::Authorization
  helper ApplicationHelper
  before_action :authenticate_user!
  after_action :verify_authorized, except: [:index, :new], unless: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized


  # after_action :track_action

  # protected

  # def track_action
  #   ahoy.track "Ran action", request.path_parameters
  # end


  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
end
