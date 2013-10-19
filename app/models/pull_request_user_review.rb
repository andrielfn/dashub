class PullRequestUserReview
  delegate :title, to: :pull_request

  attr_reader :pull_request, :user

  def initialize(pull_request, user)
    @pull_request = pull_request
    @user = user
  end

  # Public: returns true if the pull request is fully approved and ready to merge.
  def ready_to_ship?
    @pull_request.approved?
  end
  alias ready_to_merge? ready_to_ship?

  # Public: returns true if the user added a comment on pull request.
  def reviewed?
    @pull_request.commenters.include?(user.login) || @pull_request.reviewers.include?(user.login)
  end

  # Public: returns true if the user did an approve comment.
  def approved?
    @pull_request.users_approval.include?(user.login)
  end
end
