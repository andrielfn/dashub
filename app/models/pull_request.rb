class PullRequest
  attr_reader :repo, :issue_number

  def initialize(repo, issue_number)
    @repo = repo
    @issue_number = issue_number
  end

  def comments
    @comments ||= client.issue_comments(repo, issue_number)
  end

  # Public: returns the number of comments per user.
  #
  # Example:
  #   pull_request.comments_per_user
  #   # => { 'john' => 1, 'paul' => 10 }
  def comments_per_user
    stats = Hash.new { |h, k| h[k] = 0 }
    comments.each do |comment|
      stats[comment.user.login] += 1
    end
    stats
  end

  # Public: returns the number of approves made.
  #
  # TODO: pending integration with approval criteria
  def approvals_count
    comments.select do |comment|
      comment.body.include?(':shipit:')
    end.count
  end

  # Public: checks if the pull request was approved according to project criteria.
  def approved?
    approvals_count >= 2
  end

  private

  def client
    @client ||= Octokit::Client.new(access_token: ENV.fetch('GITHUB_ACCESS_TOKEN') { raise 'Github Access Token Missing' })
  end
end
