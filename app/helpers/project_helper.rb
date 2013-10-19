module ProjectHelper
  def pull_request_status(pull_request)
    if pull_request.approved?
      'approved'
    elsif pull_request.reviewed?
      'reviewed'
    elsif pull_request.ready_to_ship?
      'shipable'
    else
      'pending'
    end
  end

  def emoji_tag(name, url, options = {})
    options[:width] ||= 20
    image_tag(url, options.merge(alt: name, title: name))
  end
end
