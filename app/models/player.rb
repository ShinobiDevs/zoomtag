# == Schema Information
#
# Table name: players
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  authentication_token   :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  facebook_uuid          :string(255)
#  facebook_access_token  :string(255)
#

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
