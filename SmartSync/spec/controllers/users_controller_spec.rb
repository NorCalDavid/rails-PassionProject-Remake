require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #homes" do
    it "returns http success" do
      get :homes
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #rooms" do
    it "returns http success" do
      get :rooms
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #devices" do
    it "returns http success" do
      get :devices
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end
  end

end
