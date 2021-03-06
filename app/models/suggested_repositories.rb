# This class fetches repository suggestions for a given user, in order to aid
# them in the project creation process.
class SuggestedRepositories
  def initialize(user, project)
    @user = user
    @project = project
  end

  def repos
    @repos ||= remove_project_repos_from_user_ones
  end

  private

  def client
    @client ||= Octokit::Client.new(access_token: @user.provider_token,
                                    middleware: Octokit::Default::MIDDLEWARE)
  end

  def remove_project_repos_from_user_ones
    repos = []
    user_repos = client.repositories
    added_repos = @project.repositories.map(&:full_name)

    user_repos.each do |repo|
      unless added_repos.include?(repo.full_name)
        repos << repo
      end
    end

    repos
  end
end
