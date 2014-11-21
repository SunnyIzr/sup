require 'rails_helper'

describe MatchesController, :type => :controller do
  let(:user) {FactoryGirl.create(:user)}

  describe "GET #index" do
    it "should populate oustanding matches for a given user" do
      sign_in(user)
      3.times{FactoryGirl.create(:user)}
      allow(MatchAlgo).to receive(:run).with(user).and_return(User.all[1..3])
      user.generate_new_matches
      get :index
      expect(assigns(:matches)).to match_array(User.all[1..3])
    end
    it 'should render :index view' do
      sign_in(user)
      get :index
      expect(response).to render_template(:index)
    end
  end

end
