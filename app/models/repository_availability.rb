class RepositoryAvailability
  attr_reader :current_user, :repository

  def initialize(repository)
    @repository   = repository
  end

  def available_for?(current_user)
    @current_user = current_user

    client.repository?(repository.fullname)
  end

  private

  def client
    @client ||= Octokit::Client.new(access_token: current_user.provider_token)
  end
end
