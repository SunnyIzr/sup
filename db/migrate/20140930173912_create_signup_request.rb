class CreateSignupRequest < ActiveRecord::Migration
  def change
    create_table :signup_requests do |t|
      t.string :hex_id
      t.string :email
    end
  end
end
