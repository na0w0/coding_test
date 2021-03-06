class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  # bootstrapに対応したtypeを追加
  add_flash_types :success, :info, :warning, :danger

  include ErrorHandlers if Rails.env.production?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
