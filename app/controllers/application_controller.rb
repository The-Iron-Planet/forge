class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def user_is_cd?
    redirect_to root_path, notice: "You don't have access to that page!" unless current_user.is_cd
  end
end
