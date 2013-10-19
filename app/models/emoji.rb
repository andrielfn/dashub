class Emoji
  attr_reader :all

  def initialize
    @all ||= client.emojis.attrs
  end

  private

  def client
    @client ||= Octokit::Client.new(access_token: ENV.fetch('GITHUB_ACCESS_TOKEN') { raise 'Github Access Token Missing' })
  end
end
