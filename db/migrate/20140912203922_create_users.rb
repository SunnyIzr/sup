class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.integer :personal_rank
      t.integer :mic_style
      t.integer :play_style
      t.text :desc_words
    end
  end
end
