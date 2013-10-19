module ApplicationHelper
  def github_repository_url(repository)
    "#{github_url}#{repository.fullname}"
  end
  alias :repo_url :github_repository_url

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
end
