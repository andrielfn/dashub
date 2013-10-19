class RepositoryUserReview
  attr_reader :repository, :user

  def initialize(repository, user)
    @repository = repository
    @user = user
  end

  # Public: returns true if there is no missing pull request to review.
  def fully_reviewed?
    pull_requests_missing_review.count.zero?
  end

  # Public: returns pull requests reviewed by user.
  def pull_requests_reviewed
    partitioned_pull_requests[:reviewed]
  end

  # Public: returns pull requests already approved by user.
  def pull_requests_approved
    partitioned_pull_requests[:approved]
  end

  # Public: returns pull requests ready to ship, but reviewed by user.
  def pull_requests_ready_to_ship
    partitioned_pull_requests[:ready_to_ship]
  end

  # Public: returns pull requests that might require user review.
  def pull_requests_missing_review
    partitioned_pull_requests[:missing_review]
  end

  private

  def pull_requests_to_review
    @pull_requests_to_review ||= @repository.open_pull_requests.map do |pull_request|
      PullRequestUserReview.new(pull_request, @user)
    end
  end

  # Internal: partition the repository pull requests into different stacks.
  #
  # Current stacks are:
  #   - approved: user already approved (implies that it reviewed)
  #   - reviewed: user already reviewed
  #   - ready_to_ship: ready to ship but missing user review
  #   - missing_review: missing user review
  #
  # Returns a hash with a stack of pull requests to review according to each state.
  def partitioned_pull_requests
    # TODO: improve
    @partitioned_pull_requests ||= begin
      partitions = Hash.new { |h, k| h[k] = [] }
      pull_requests_to_review.each do |review|
        if review.approved?
          partitions[:approved] << review
        elsif review.reviewed?
          partitions[:reviewed] << review
        elsif review.ready_to_ship?
          partitions[:ready_to_ship] << review
        else
          partitions[:missing_review] << review
        end
      end
      partitions
    end
  end
end
