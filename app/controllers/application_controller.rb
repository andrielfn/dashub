class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  # TODO: remove when add devise
  def current_user
    @current_user ||= User.new
  end
end
