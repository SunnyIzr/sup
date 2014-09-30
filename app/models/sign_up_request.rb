class SignUpRequest < ActiveRecord::Base
  def self.generate_new(email)
    sign_up_request = SignUpRequest.create(hex_id: SecureRandom.hex, email: email)
  end
end