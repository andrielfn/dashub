module ProjectHelper
  def pull_request_count(repository)
    if repository.too_many_open_pull_requests?
      "#{Repository::GH_API_PER_PAGE}+"
    else
      repository.pull_requests_to_review.size
    end
  end

  def approved_pull_request_count(repository)
    repository.pull_requests_to_review.find_all(&:approved?).size
  end

  def emoji_tag(name, url, options = {})
    width = options[:width] || 20
    image_tag(url, width: width, alt: name, title: name)
  end
end
