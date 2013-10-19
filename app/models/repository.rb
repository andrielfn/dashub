class Repository < ActiveRecord::Base
  GH_API_PER_PAGE = 30

  validates :name, presence: true
  validates :url, presence: true

  belongs_to :project

  # Public: returns open pull requests in repository.
  def open_pull_requests
    @pull_requests ||= client.pull_requests(github_format, 'open').map do |data|
      PullRequest.new(data)
    end
  end

  # True if the repository has `GH_API_PER_PAGE` open pull requests and there is
  # a next page.
  def too_many_open_pull_requests?
    open_pull_requests.size == GH_API_PER_PAGE && client.last_response.rels[:next].present?
  end

  def github_format
    url[%r{github\.com/([\w]+/[\w_-]+)}, 1]
  end

  private

  def client
    @client ||= Octokit::Client.new(access_token: ENV.fetch('GITHUB_ACCESS_TOKEN') { raise 'Github Access Token Missing' })
  end
end
