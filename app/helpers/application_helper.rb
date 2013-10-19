module ApplicationHelper
  def github_repository_url(repository)
    "#{github_url}#{repository.fullname}"
  end
  alias :repo_url :github_repository_url

  def github_url
    "http://github.com/"
  end
end
