# This class fetches repository suggestions for a given user, in order to aid
# them in the project creation process.
class SuggestedRepositories
  def initialize(user)
    @user = user
  end

  def repos
    @repos ||= client.repositories
  end

  private

  def client
    @client ||= Octokit::Client.new(access_token: @user.provider_token)
  end
end
