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

  describe "GET show" do
    it "return a signup page for a specified signup_request hex id" do
      signup_request = SignupRequest.generate_new('john1@doe.com')
      get :show, {hex_id: signup_request.hex_id}
      expect(assigns(:signup_request)).to eq(SignupRequest.last)
    end
    it 'should render :show view' do
      signup_request = SignupRequest.generate_new('john1@doe.com')
      get :show, {hex_id: signup_request.hex_id}
      expect(response).to render_template(:show)
    end
  end

end
