class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def current_user_or_guest_user
    ActiveSupport::Deprecation.warn("Replace with current_user once Rails Rumble is finished")

    @current_user_or_guest_user ||= if user_signed_in?
      current_user
    else
      User.find_by_username!(ENV.fetch('GUEST_USER') { raise "Missing ENV['GUEST_USER']" })
    end
  end
end
