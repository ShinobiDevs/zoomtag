class AddWaitingToChallangeToGames < ActiveRecord::Migration
  def change
    add_column :games, :waiting_to_challange, :boolean, default: true
  end
end
