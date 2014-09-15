class CreateMatchTraits < ActiveRecord::Migration
  def change
    create_table :match_traits do |t|
      t.string :description
    end
  end
end
