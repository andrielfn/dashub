# Fetches a list of all emojis in GitHub API or can find the URL for a specific emoji.
#
# Examples
#
#   Emoji.all
#   # => [[:'+1', 'https://github/com/assets/images/...'], [:man, 'http://...']]
#
#   Emoji.new('green_heart').url
#   # => 'http://github.com/assets/images/...'
#
#   Emoji.new('invalid').url # => nil
class Emoji
  class << self
    def all
      @emojis ||= client.emojis.attrs
    end

    private

    def client
      @client ||= Octokit::Client.new(access_token: ENV.fetch('GITHUB_ACCESS_TOKEN') { raise 'Github Access Token Missing' })
    end
  end

  def initialize(emoji)
    @emoji = emoji.to_sym
  end

  def name
    @emoji.to_s
  end

  def url
    emoji = Emoji.all.find { |e| e.first == @emoji }

    if emoji
      emoji.last
    end
  end
end
