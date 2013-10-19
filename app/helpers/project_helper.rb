module ProjectHelper
  def pull_request_count(repository)
    if repository.too_many_open_pull_requests?
      "#{Repository::GH_API_PER_PAGE}+"
    else
      repository.open_pull_requests.size
    end
  end
end
