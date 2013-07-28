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

  def as_json(options = {})
    super(options.merge(methods: [:next_challange]))
  end
  def next_challange
    self.challanges.last
  end
end
