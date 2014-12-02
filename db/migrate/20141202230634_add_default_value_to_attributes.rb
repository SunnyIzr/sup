class AddDefaultValueToAttributes < ActiveRecord::Migration
  def change
    change_column :users, :personal_rank, :integer, default: 50
    change_column :users, :mic_style, :integer, default: 50
    change_column :users, :play_style, :integer, default: 50
  end
end
