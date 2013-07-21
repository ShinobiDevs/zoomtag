class AddFacebookUuidAndFacebookAccessTokenToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :facebook_uuid, :string
    add_column :players, :facebook_access_token, :string

    add_index :players, :facebook_uuid
    add_index :players, :facebook_access_token
  end
end
