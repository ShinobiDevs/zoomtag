class AddGameIdToChallanges < ActiveRecord::Migration
  def change
    add_column :challanges, :game_id, :integer
    drop_table :challanges_games
  end
end
