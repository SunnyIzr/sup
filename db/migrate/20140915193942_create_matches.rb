class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.belongs_to :user
      t.integer :matched_user_id
      t.timestamps
    end
  end
end
