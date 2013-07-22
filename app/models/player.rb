class Player < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :token_authenticatable

  def games
    Game.scoped.where(["player1_id = :id OR player2_id = :id", {:id => self.id}])
  end
end
