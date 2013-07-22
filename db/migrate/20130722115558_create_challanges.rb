class CreateChallanges < ActiveRecord::Migration
  def change
    create_table :challanges do |t|
      t.column :image_url, :string
      t.column :easy_tag, :string
      t.column :medium_tag, :string
      t.column :hard_tag, :string
      t.column :player_id, :integer
      t.column :hint, :string
      t.timestamps
    end

    create_table :challanges_games, :id => false do |t|
      t.column :game_id, :integer
      t.column :challange_id, :integer
    end

    add_index :challanges_games, :game_id
    add_index :challanges_games, :challange_id
  end
end
