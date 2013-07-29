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

  def advance_turn!
    self.current_turn = (current_turn == player1_id ? player2_id : player1_id)
    self.waiting_to_challange = true
    save!
  end

  def score!(player, score)
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
end
