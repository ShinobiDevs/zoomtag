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

  before_save :downcase_tags

  validates :easy_tag, :medium_tag, :hard_tag, presence: true
  
  protected

  def downcase_tags
    self.easy_tag = self.easy_tag.downcase
    self.medium_tag = self.medium_tag.downcase
    self.hard_tag = self.hard_tag.downcase
  end
end
