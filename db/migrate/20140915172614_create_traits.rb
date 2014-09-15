class CreateTraits < ActiveRecord::Migration
  def change
    create_table :traits do |t|
      t.string :description
    end
  end
end
