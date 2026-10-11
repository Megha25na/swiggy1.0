class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :cart, :current_cart

  stale_when_importmap_changes

  def cart
    @cart ||= Cart.new(session)
  end
  alias_method :current_cart, :cart

  def require_admin!
    unless current_user&.admin?
      redirect_to root_path, alert: "Access denied. Administrator privileges required."
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :name, :phone, :address, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: [:email, :name, :phone, :address, :password, :password_confirmation, :current_password])
  end
end

