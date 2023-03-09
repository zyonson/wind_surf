require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { FactoryBot.create(:user) }

  describe "GET /index" do
    it "returns http success" do
      log_in_as user
      get users_path
      expect(response).to have_http_status(:success)
    end
  end
  #   describe "GET /show" do
  #     it "returns http success" do
  #       user.avatar.attach(io: File.open(
  #         Rails.root.join('app', 'assets', 'images', 'default_icon.jpg')
  #       ), filename: 'default_icon.jpg', content_type: 'image/jpg')
  #       get user_path(user)
  #       expect(response).to have_content "aw"
  #       expect(response).to have_http_status(:success)
  #     end
  #   end
  describe "GET /new" do
    it "returns http success" do
      get new_user_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      log_in_as user
      get edit_user_path(user)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
    end
  end

  let!(:user) { FactoryBot.create(:user) }
  let!(:admin) { FactoryBot.create(:admin) }
  it 'succeds when user is administrator' do
    log_in_as admin
    expect do
      delete user_path(user)
    end.to change(User, :count).by(-1)
  end
end
