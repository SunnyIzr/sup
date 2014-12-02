class ChangeColumnInMatches < ActiveRecord::Migration
  def change
    rename_column :matches, :ignored, :actioned
  end
end
