require 'rails_helper'

RSpec.describe IndexController, type: :controller do

  describe "GET #home" do
    it "returns http success" do
      get :home
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #players" do
    it "returns http success" do
      get :players
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #games" do
    it "returns http success" do
      get :games
      expect(response).to have_http_status(:success)
    end
  end

end
