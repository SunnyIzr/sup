require 'rails_helper'

RSpec.describe StaticPagesController, :type => :controller do

  describe "GET index" do
    it "should render :index view" do
      get :index
      expect(response).to render_template(:index)
    end
  end

end
