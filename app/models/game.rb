# == Schema Information
#
# Table name: games
#
#  id                   :integer          not null, primary key
#  player1_id           :integer
#  player2_id           :integer
#  started_by_player_id :integer
#  current_turn         :integer
#  created_at           :datetime
#  updated_at           :datetime
#  waiting_to_challange :boolean          default(TRUE)
#

class Game < ActiveRecord::Base

  has_many :challanges

  belongs_to :player1, :class_name => "Player", :foreign_key => "player1_id"
  belongs_to :player2, :class_name => "Player", :foreign_key => "player2_id"

  after_create :register_games

  def advance_turn!
    self.current_turn = (current_turn == player1_id ? player2_id : player1_id)
    self.waiting_to_challange = true
    save!
  end

  def playing?(player)
    return ((player.id == player1_id) || (player.id == player2_id))
  end

  def score!(player, score)
    return false unless playing?(player)
    score = case score.downcase
    when "easy"
      5
    when "medium"
      10
    when "hard"
      20
    else
      0
    end
    $redis.incrby("games:#{self.id}:player:#{player.id}", score.to_i)
    $leaderboard.rank_member(player.id, score.to_i)
    $leaderboard.update_member_data(player.id, JSON.generate({name: player.name, last_played: Time.now.to_i}))
    true
  end

  def get_score_for_player(player)
    $redis.get("games:#{self.id}:player:#{player.id}").to_i
  end

  def scores
    {
      player1: get_score_for_player(player1),
      player2: get_score_for_player(player2),
    }
  end

  def as_json(options = {})
    super(options.merge(methods: [:next_challange, :scores], include: [:player1, :player2]))
  end
  
  def next_challange
    self.challanges.last
  end

  protected

  def register_games
    $redis.multi do
      $redis.sadd "player:#{player1_id}:games", self.id
      $redis.sadd "player:#{player2_id}:games", self.id
      $redis.sadd "player:#{player1_id}:playing_with", player2.facebook_uuid
      $redis.sadd "player:#{player2_id}:playing_with", player1.facebook_uuid
    end
  end
end
