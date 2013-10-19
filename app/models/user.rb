class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :omniauthable, omniauth_providers: [:github]

  def self.find_for_github_oauth(auth, signed_in_resource=nil)
    user = User.where(provider: auth.provider, uid: auth.uid).first
    unless user
      user = User.create(name: sauth.extra.raw_info.name,
                         provider: sauth.provider,
                         uid: sauth.uid,
                         email: sauth.info.email,
                         password: sDevise.friendly_token[0, 20])
    end

    user
  end
end
