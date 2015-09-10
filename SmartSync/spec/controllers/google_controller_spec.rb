require 'rails_helper'

RSpec.describe GoogleController, type: :controller do

  describe "GET #oauth" do
    it "returns http success" do
      get :oauth
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #token" do
    it "returns http success" do
      get :token
      expect(response).to have_http_status(:success)
    end
  end

end
