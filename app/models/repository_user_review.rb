class RepositoryUserReview
  attr_reader :repository, :user

  def initialize(repository, user)
    @repository = repository
    @user = user

    partition_pull_requests
  end

  # Public: returns true if there is no missing pull request to review.
  def fully_reviewed?
    pull_requests_missing_review.count.zero?
  end

  # Public: returns pull requests that might require user review.
  def pull_requests_missing_review
    @missing_review
  end

  # Public: returns pull requests reviewed by user.
  def pull_requests_reviewed
    @reviewed
  end

  private

  # Internal: partition the repository pull requests into reviewed and missing review.
  def partition_pull_requests
    @reviewed, @missing_review = @repository.open_pull_requests.partition do |pull_request|
      pull_request.users_approval.include?(@user.login)
    end
  end
end
