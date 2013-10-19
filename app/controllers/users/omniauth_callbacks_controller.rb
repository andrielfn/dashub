class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github
    @user = User.find_for_github_oauth(request.env['omniauth.auth'], current_user)

    if @user.persisted? && user_signed_in?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Github') if is_navigational_format?
    end
  end

  protected

  def after_omniauth_failure_path_for(scope)
    root_path
  end
end
