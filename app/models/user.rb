class User < ActiveRecord::Base
  devise :trackable, :omniauthable, omniauth_providers: [:github]

  has_many :projects

  def self.find_for_github_oauth(auth, signed_in_resource=nil)
    User.where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      user.name = auth.extra.raw_info.name
      user.username = auth.extra.raw_info.login
      user.email = auth.info.email
      user.uid = auth.uid
      user.provider = auth.provider
      user.provider_token = auth.credentials.token
      user.provider_token_expires = auth.credentials.expires
    end
  end
end
