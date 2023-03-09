require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:user) }

  describe "user validation" do
    it "is invalid if user name is nil" do
      user = User.new(name: nil)
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end
    it "is invalid if email is invalid format" do
      user = User.new(email: 'aaa')
      user.valid?
      expect(user.errors[:email]).to include('is invalid')
    end
    it 'is invalid if email is more than 255 characters ' do
      user = User.new(email: 'a' * 256)
      user.valid?
      expect(user.errors[:email]).to include('is too long (maximum is 255 characters)')
    end

    it 'is invalid if userpassword is less than 6 characters' do
      user = User.new(password: 'a' * 5)
      user.valid?
      expect(user.errors[:password]).to include('is too short (minimum is 6 characters)')
    end
  end
end
