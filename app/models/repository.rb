class Repository < ActiveRecord::Base
  GH_API_PER_PAGE = 30
  SUGGESTED_EMOJIS = ['+1', 'shipit', '100', 'smile', 'heart']

  validates :full_name,
    presence: true,
    uniqueness: { scope: :project_id, message: 'repo already in this project' },
    format: { with: /^[^\/\s]+\/[^\/\s]+$/, multiline: true }

  belongs_to :project

  # Public: returns the repository owner.
  def owner
    @owner ||= full_name.split('/').first
  end

  # Public: returns the repository name.
  def name
    @name ||= full_name.split('/').last
  end

  private

  def client
    @client ||= Octokit::Client.new(access_token: ENV.fetch('GITHUB_ACCESS_TOKEN') { raise 'Github Access Token Missing' })
  end
end
