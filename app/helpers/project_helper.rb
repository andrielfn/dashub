module ProjectHelper
  def pull_request_status(pull_request)
    if pull_request.approved?
      'approved'
    elsif pull_request.reviewed?
      'reviewed'
    elsif pull_request.ready_to_ship?
      'shippable'
    else
      'pending'
    end
  end

  def pull_request_status_description(pull_request)
    pull_request_status = pull_request_status(pull_request)

    descriptions = {
      'approved' => 'Reviewed by you and ready to merge',
      'reviewed' => 'Reviewed but waiting for your approval',
      'shippable' => 'Ready to merge, but not reviewed by you',
      'pending' => 'No one reviewed yet'
    }

    descriptions[pull_request_status]
  end

  def emoji_tag(name, url, options = {})
    options[:width] ||= 20
    image_tag(url, options.merge(alt: name, title: name))
  end
end
