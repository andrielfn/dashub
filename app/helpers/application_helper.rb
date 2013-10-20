module ApplicationHelper
  def github_repository_url(repository)
    "#{github_url}#{repository.full_name}"
  end
  alias :repo_url :github_repository_url

  def organization_url(repository)
    "#{github_url}#{repository.owner}"
  end

  def github_url
    "http://github.com/"
  end

  def flash_messages
    messages = ''

    [:alert, :notice, :warning, :error].each do |type|
      if flash[type]
        messages += "<p class='flash-message #{type}'>#{flash[type]}</p>"
      end
    end

    messages.html_safe
  end

  def gravatar_url(email, size = '48')
    gravatar_id = Digest::MD5.hexdigest(email)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
  end
end
