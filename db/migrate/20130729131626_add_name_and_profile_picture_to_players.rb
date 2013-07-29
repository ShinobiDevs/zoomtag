class AddNameAndProfilePictureToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :name, :string
    add_column :players, :profile_picture, :string
  end
end
