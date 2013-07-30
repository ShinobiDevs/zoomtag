# == Schema Information
#
# Table name: challanges
#
#  id         :integer          not null, primary key
#  image_url  :string(255)
#  easy_tag   :string(255)
#  medium_tag :string(255)
#  hard_tag   :string(255)
#  player_id  :integer
#  hint       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Challange < ActiveRecord::Base

  belongs_to :game
  belongs_to :player

  belongs_to :guessed_by, class_name: "Player"
  before_save :downcase_tags
  after_create :advance_game_turn

  validates :easy_tag, :medium_tag, :hard_tag, presence: true

  def answer(difficulty)
    if self.respond_to?("#{difficulty.downcase}_tag")
      self.send("#{difficulty.downcase}_tag")
    else
      false
    end
  end

  protected

  def advance_game_turn
    self.game.advance_turn!
  end

  def downcase_tags
    self.easy_tag = self.easy_tag.downcase
    self.medium_tag = self.medium_tag.downcase
    self.hard_tag = self.hard_tag.downcase
  end
end
