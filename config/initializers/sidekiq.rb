# frozen_string_literal: true

redis_path = Rails.root.join('config', 'redis.yml').to_s
config = YAML.load(ERB.new(File.read(redis_path)).result)[Rails.env].with_indifferent_access

redis_conn = { url: "redis://#{config[:host]}:#{config[:port]}/" }

Sidekiq.configure_server do |s|
  s.redis = redis_conn
end

Sidekiq.configure_client do |s|
  s.redis = redis_conn
end
