class PullRequest
  delegate :title, to: :@pull_request

  # TODO: remove, it is only used for debug purpose
  attr_reader :pull_request

  def initialize(pull_request)
    @pull_request = pull_request
  end

  def comments
    @comments ||= pull_request.rels[:comments].get.data
  end

  def url
    @pull_request._links.html.href
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

  # Public: returns the number of approvals required.
  def required_approvals
    # TODO: implement
    2
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
  # TODO: pending integration with approval criteria
  # TODO: ignore duplicated approvals
  def approvals_count
    comments.select do |comment|
      comment.body.include?(':shipit:')
    end.count
  end

  # Public: checks if the pull request was approved according to project criteria.
  def approved?
    approvals_count >= required_approvals
  end
end
