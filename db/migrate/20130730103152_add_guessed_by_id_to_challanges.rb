class AddGuessedByIdToChallanges < ActiveRecord::Migration
  def change
    add_column :challanges, :guessed_by_id, :integer
  end
end
