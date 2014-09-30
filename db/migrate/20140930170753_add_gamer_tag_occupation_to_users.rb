class AddGamerTagOccupationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :occupation, :string
    add_column :users, :gamertag, :string
  end
end
