class Repository < ActiveRecord::Base
  validates :name, presence: true
  validates :url, presence: true

  belongs_to :project

  # Public: returns open pull requests in repository.
  #
  # TODO: check pagination
  def open_pull_requests
    @pull_requests ||= client.pull_requests(github_format, 'open').map do |data|
      PullRequest.new(data)
    end
  end

  def github_format
    url[%r{github\.com/([\w]+/[\w_-]+)}, 1]
  end

  private

  def client
    @client ||= Octokit::Client.new(access_token: ENV.fetch('GITHUB_ACCESS_TOKEN') { raise 'Github Access Token Missing' })
  end
end
