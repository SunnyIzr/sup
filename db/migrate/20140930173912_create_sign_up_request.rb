class CreateSignUpRequest < ActiveRecord::Migration
  def change
    create_table :sign_up_requests do |t|
      t.string :hex_id
      t.string :email
    end
  end
end
