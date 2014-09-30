class SignupRequest < ActiveRecord::Base
  def self.generate_new(email)
    signup_request = SignupRequest.create(hex_id: SecureRandom.hex, email: email)
  end
end