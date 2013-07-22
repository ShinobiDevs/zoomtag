class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.column :player1_id, :integer
      t.column :player2_id, :integer
      t.column :started_by_player_id, :integer
      t.column :current_turn, :integer
      t.timestamps
    end

    add_index :games, :player2_id
    add_index :games, :player1_id
  end
end
