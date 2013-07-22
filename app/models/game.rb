class Game < ActiveRecord::Base

  has_and_belongs_to_many :challanges

  belongs_to :player1, :class_name => "Player", :foreign_key => "player1_id"
  belongs_to :player2, :class_name => "Player", :foreign_key => "player2_id"

  def advance_turn!
    self.current_turn = (current_turn == player1_id ? player2_id : player1_id)
    save!
  end
end
