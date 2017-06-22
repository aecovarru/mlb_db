require 'rails_helper'

RSpec.describe ShowController, type: :controller do

  describe "GET #game" do
    it "returns http success" do
      get :game
      expect(response).to have_http_status(:success)
    end
  end

end
