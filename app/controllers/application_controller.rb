class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :update_sanitized_params, if: :devise_controller?

  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:email, :password, :password_confirmation, 
               :remember_me, :first_name, :last_name, :profile_name, :full_name, :avatar)}
  end
  

  protected

  # User "strong params"; replacement for attr_accessible
  def user_params
    params.require(:user).permit(:user_id, :first_name, :last_name, :email, :password, :password_confirmation, :user, :friend, :friend_id)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) do |u| 
      u.permit(:profile_name, :email, :password, :first_name, :last_name, :avatar)
    end
    devise_parameter_sanitizer.for(:sign_up) do |u| 
      u.permit(:email, :password, :password_confirmation, 
               :remember_me, :first_name, :last_name, :profile_name, :full_name, :avatar)
    end
    devise_parameter_sanitizer.for(:account_update) do |u| 
      u.permit(:email, :password, :password_confirmation, :current_password,
               :remember_me, :first_name, :last_name, :profile_name, :full_name, :avatar)
    end
  end
end
