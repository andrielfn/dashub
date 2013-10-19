class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    @user = User.find_for_github_oauth(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "Github") if is_navigational_format?
    else
      session["devise.github_data"] = request.env["omniauth.auth"]
      redirect_to root_path
    end
  end

  protected

  def after_omniauth_failure_path_for(scope)
    root_path
  end

  def after_sign_in_path_for(resource)
    root_path
  end
end
