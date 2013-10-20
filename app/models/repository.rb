class Repository < ActiveRecord::Base
  GH_API_PER_PAGE = 30
  SUGGESTED_EMOJIS = ['thumbsup', 'shipit', '100', 'smile', 'heart']

  validates :full_name,
    presence: true,
    uniqueness: { scope: :project_id, message: 'repo already in this project' },
    format: { with: /^[^\/\s]+\/[^\/\s]+$/, multiline: true }

  belongs_to :project

  private

  def client
    @client ||= Octokit::Client.new(access_token: ENV.fetch('GITHUB_ACCESS_TOKEN') { raise 'Github Access Token Missing' })
  end
end
