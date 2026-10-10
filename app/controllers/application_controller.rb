class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :authenticate_user!
   before_action :configure_permitted_parameters, if: :devise_controller?


  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :name, :description, :password, :password_confirmation])
  end
end
