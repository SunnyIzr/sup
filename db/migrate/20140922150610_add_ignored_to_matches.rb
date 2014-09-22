class AddIgnoredToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :ignored, :boolean, default: false
  end
end
