class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticated_this_month

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def authenticated_this_month
    @authenticated_this_month = Month.find_by(user_id: current_user.id, month: Date.today.beginning_of_month)
    @month = Month.find_by(user_id: current_user.id, month: Date.today.beginning_of_month)
  end
end
