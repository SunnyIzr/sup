class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :date_of_birth, :date
    add_column :users, :postal_code, :string
  end
end
