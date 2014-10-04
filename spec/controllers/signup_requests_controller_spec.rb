require 'rails_helper'

RSpec.describe SignupRequestsController, :type => :controller do

  describe "GET create" do
    it "should create a new signup request with a generated hex key" do
      post :create, {signup_request: {email: 'john@doe.com'} }
      expect(SignupRequest.last.email).to eq('john@doe.com')
    end
    it 'should send initiate a signup request email'
    it 'should render success json'
  end

end
