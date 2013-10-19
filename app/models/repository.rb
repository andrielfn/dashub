class Repository < ActiveRecord::Base
  GH_API_PER_PAGE = 30
  SUGGESTED_EMOJIS = ['thumbsup', 'shipit', '100', 'smile', 'heart']

  validates :fullname,
    presence: true,
    format: { with: /^[^\/\s]+\/[^\/\s]+$/, multiline: true }

  belongs_to :project

  # Public: returns open pull requests in repository.
  def open_pull_requests
    @pull_requests ||= client.pull_requests(fullname, 'open').map do |resource|
      pull = PullRequest.new(fullname, resource.number, self.project)
      pull.pull_request = resource
      pull
    end
  end

  # True if the repository has `GH_API_PER_PAGE` open pull requests and there is
  # a next page.
  def too_many_open_pull_requests?
    open_pull_requests.size == GH_API_PER_PAGE && client.last_response.rels[:next].present?
  end

  private

  def client
    @client ||= Octokit::Client.new(access_token: ENV.fetch('GITHUB_ACCESS_TOKEN') { raise 'Github Access Token Missing' })
  end
end
