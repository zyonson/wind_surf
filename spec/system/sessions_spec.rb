require 'rails_helper'

RSpec.describe 'Sessions', type: :system do
  before do
    driven_by(:rack_test)
  end
  let(:user) { FactoryBot.create(:user) }
  before do
    visit edit_user_path(user)
    user.avatar.attach(io: File.open(
        Rails.root.join('app', 'assets', 'images', 'default_icon.jpg') # rubocop:disable all
      ), filename: 'default_icon.jpg', content_type: 'image/jpg')
    fill_in 'Name', with: user.name
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    click_on 'Save Change'
  end
  scenario "login" do
    visit login_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on "Log in"
    expect(current_path).to eq user_path(user.id)
    expect(page).to have_content('login success')
  end
  scenario "logout" do
    login(user)
    click_on "logout"
    expect(current_path).to eq login_path
    expect(page).to have_content('logout')
  end
end
