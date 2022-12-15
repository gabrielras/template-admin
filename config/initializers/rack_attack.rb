# frozen_string_literal: true

# config/initializers/rack_attack.rb (for rails apps)

Rack::Attack.enabled = ENV['ENABLE_RACK_ATTACK'] || Rails.env.production?

Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new if !ENV['REDIS_URL'] || Rails.env.test?

# bad_ips = ENV['BLOCKED_IPS'].try(:split, ',')
# Rack::Attack.blocklist "Block IPs from Environment Variable" do |req|
#   bad_ips.include?(req.ip)
# end

Rack::Attack.cache.store = Redis.new(url: ENV['REDIS_FOR_RACK_ATTACK_URL']) if ENV['REDIS_FOR_RACK_ATTACK_URL']

# Ban Pentesters
Rack::Attack.blocklist('fail2ban pentesters') do |req|
  # `filter` returns truthy value if request fails, or if it's from a previously banned IP
  # so the request is blocked
  Rack::Attack::Fail2Ban.filter("pentesters-#{req.ip}",
                                maxretry: 3,
                                findtime: 10.minutes,
                                bantime: 30.minutes) do
    # The count for the IP is incremented if the return value is truthy
    CGI.unescape(req.query_string).include?('/etc/passwd') ||
      req.path.include?('/etc/passwd') ||
      req.path.include?('wp-admin') ||
      req.path.include?('wp-login') ||
      req.path.include?('/.env') ||
      req.path.include?('/dbadmin') ||
      req.path.include?('/mysql') ||
      req.path.include?('/webdav')
  end
end

# Lockout IP addresses that are hammering your login page.
# After 20 requests in 1 minute, block all requests from that IP for 1 hour.
Rack::Attack.blocklist('allow2ban login scrapers') do |req|
  # `filter` returns false value if request is to your login page (but still
  # increments the count) so request below the limit are not blocked until
  # they hit the limit.  At that point, filter will return true and block.
  Rack::Attack::Allow2Ban.filter(req.ip,
                                 maxretry: 20,
                                 findtime: 1.minute,
                                 bantime: 1.hour) do
    # The count for the IP is incremented if the return value is truthy.
    req.path.include?('/auth_tokens') and req.post?
  end
end

# Throttle login attempts for a given email parameter to 6 reqs/minute
# Return the *normalized* email as a discriminator on POST /login requests
Rack::Attack.throttle('limit logins per username', limit: 10, period: 60) do |req|
  if req.path == '/login' && req.post?
    # Normalize the username, using the same logic as your authentication process, to
    # protect against rate limit bypasses.
    req.params['username'].to_s.downcase.gsub(/\s+/, '')
  end
end
