Sidekiq.configure_server do |config|
  config.redis = { url: "redis://#{ENV["REDIS_HOST"]}:#{ENV["REDIS_PORT"]}/10", password: ENV["REDIS_PASSWORD"]}
  #scheduling cron job
  schedule_file = "config/schedule.yml"
  if File.exists?(schedule_file) && Sidekiq.server?
    Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://#{ENV["REDIS_HOST"]}:#{ENV["REDIS_PORT"]}/10", password: ENV["REDIS_PASSWORD"]}
end