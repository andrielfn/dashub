class PullRequestUserReview
  delegate :title, to: :pull_request

  attr_reader :user, :number, :repo

  def initialize(repo, number, user, project)
    @repo    = repo
    @number  = number
    @user    = user
    @project = project
  end

  # Public: returns the Github pull request resource.
  def pull_request
    @pull_request ||= client.pull_request(repo, number)
  end
  attr_writer :pull_request

  # Public: returns the issue comments on pull request.
  #
  # TODO: perform pagination
  def comments
    @comments ||= client.issue_comments(repo, number)
  end

  # Public: returns users that commented on pull request.
  def commenters
    @commenters ||= comments.index_by { |comment| comment.user.login }.keys
  end

  # Public: returns code review comments on pull request.
  #
  # TODO: perform pagination
  def code_reviews
    @code_reviews ||= client.issue_comments(repo, number)
  end

  # Public: returns users that reviewed the code on pull request.
  def reviewers
    @reviewers ||= code_reviews.index_by { |comment| comment.user.login }.keys
  end

  # Public: the html pull request public url.
  def url
    pull_request._links.html.href
  end

  # Returns the date in which the pull request was created.
  def open_date
    pull_request.created_at
  end

  # Public: returns the list of users that approved the pull request.
  def users_approval
    approval_comments.index_by { |comment| comment.user.login }.keys
  end

  # Public: returns the number of approvals required.
  def required_approvals
    @project.required_approvals
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

  # Public: returns the number of missing approvals.
  #
  # It returns 0 if fullfilled.
  def missing_approvals
    count = required_approvals - approvals_count

    if count < 0
      0
    else
      count
    end
  end

  # Public: returns the number of approves made.
  #
  # TODO: ignore duplicated approvals
  def approvals_count
    approval_comments.count
  end

  # Public: returns true if the pull request is fully approved and ready to merge.
  def ready_to_ship?
    approvals_count >= required_approvals
  end
  alias ready_to_merge? ready_to_ship?

  # Public: returns true if the user added a comment on pull request.
  def reviewed?
    commenters.include?(user.username) || reviewers.include?(user.username)
  end

  # Public: returns true if the user did an approve comment.
  def approved?
    users_approval.include?(user.username)
  end

  private

  def client
    @client ||= Octokit::Client.new(access_token: ENV.fetch('GITHUB_ACCESS_TOKEN') { raise 'Github Access Token Missing' })
  end

  # Internal: return the approval comments.
  def approval_comments
    @approval_comments ||= comments.select do |comment|
      comment.body.include?(approval_emoji)
    end
  end

  def approval_emoji
    ":#{@project.approval_emoji}:"
  end
end
