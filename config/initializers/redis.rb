# Initalize Redis
require_relative '../redis_configuration'
$redis = Redis.new(REDIS_CONFIG)
$leaderboard = Leaderboard.new('highscores', Leaderboard::DEFAULT_OPTIONS, {:redis_connection => $redis})