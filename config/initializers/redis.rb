# Initalize Redis

if Rails.env.development?
  require_relative '../redis_configuration'
  $redis = Redis.new(REDIS_CONFIG)
else
  ENV["REDISTOGO_URL"] = 'redis://redistogo:6fe9fea76126da197cd0f0b4baed0647@crestfish.redistogo.com:9609/'
  uri = URI.parse(ENV["REDISTOGO_URL"])
  $redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
end
$leaderboard = Leaderboard.new('highscores', Leaderboard::DEFAULT_OPTIONS, {:redis_connection => $redis})