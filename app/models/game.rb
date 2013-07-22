class Game < ActiveRecord::Base

  has_and_belongs_to_many :challanges

  belongs_to :player1, :class_name => "Player", :foreign_key => "player1_id"
  belongs_to :player2, :class_name => "Player", :foreign_key => "player2_id"

end
