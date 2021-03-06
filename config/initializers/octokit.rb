stack = Faraday::Builder.new do |builder|
  builder.use FaradayMiddleware::Caching, Rails.cache if Rails.env.production?
  builder.use Octokit::Response::RaiseError
  builder.adapter Faraday.default_adapter
end

Octokit.configure do |c|
  c.middleware = stack
end
