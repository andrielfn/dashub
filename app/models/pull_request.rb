class PullRequest
  attr_reader :repo, :issue_number

  def initialize(repo, issue_number)
    @repo = repo
    @issue_number = issue_number
  end

  def comments
    client.issue_comments(repo, issue_number)
  end

  private

  def client
    @client ||= Octokit::Client.new(access_token: ENV.fetch('GITHUB_ACCESS_TOKEN') { raise 'Github Access Token Missing' })
  end
end
