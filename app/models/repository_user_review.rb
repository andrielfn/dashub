class RepositoryUserReview
  attr_reader :repo, :user, :project

  def initialize(repo, user, project)
    @repo = repo
    @user = user
    @project = project
  end

  alias :full_name :repo

  # True if the repository has `GH_API_PER_PAGE` open pull requests and there is
  # a next page.
  def too_many_open_pull_requests?
    pull_requests_to_review.size == GH_API_PER_PAGE && client.last_response.rels[:next].present?
  end

  def pull_requests_to_review
    per_page = ENV.fetch('PULLS_COUNT', 10)
    @pull_requests_to_review ||= client.pull_requests(repo, 'open').first(per_page).map do |resource|
      review = PullRequestUserReview.new(repo, resource.number, @user, project)
      review.pull_request = resource
      review
    end
  end

  # Public: returns the priorited pull requests to review.
  def priorited_pull_requests
    [:missing_review, :reviewed, :ready_to_ship, :approved].flat_map do |state|
      partitioned_pull_requests[state]
    end
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

  def client
    @client ||= Octokit::Client.new(access_token: @user.provider_token)
  end
end
