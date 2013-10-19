class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    p '================================================================================'
    p request.env['omniauth.auth']

    @user = User.find_for_github_oauth(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "Github") if is_navigational_format?
    end
  end
end
