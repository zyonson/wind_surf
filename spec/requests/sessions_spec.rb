require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  let(:user) { FactoryBot.create(:user) }
  describe "GET /new" do
    it "returns http success" do
      get login_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "remember me" do
    it "rremembers the cookie when user checks the Remember Me box" do
      log_in_as(user)
      expect(cookies[:remember_token]).not_to eq nil
    end
    it "does not remembers the cookie when user does not checks the Remember Me box" do
      log_in_as(user, remember_me: '0')
      expect(cookies[:remember_token]).to eq nil
    end
  end
end
