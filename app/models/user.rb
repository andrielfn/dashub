class User < ActiveRecord::Base
  devise :trackable, :omniauthable, omniauth_providers: [:github]

  def self.find_for_github_oauth(auth, signed_in_resource=nil)
    User.where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      user.name = auth.extra.raw_info.name
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.username = auth.extra.raw_info.login
    end
  end
end
