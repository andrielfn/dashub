class PullRequestEtag
  def initialize(repository, token)
    @repository = repository
    @token = token
  end

  def etag
    request = Net::HTTP::Head.new(request_uri)
    request['Authorization'] = "token #{@token}"
    request['Accept'] = "application/vnd.github.beta+json"

    http = Net::HTTP.new(request_uri.hostname, request_uri.port)
    http.use_ssl = true
    response = http.request(request)

    response['ETag']
  end

  private

  def request_uri
    @uri ||= URI("https://api.github.com/repos/#{@repository}/pulls")
  end
end
