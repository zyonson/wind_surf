require 'rails_helper'

RSpec.describe 'User', type: :system do
  include SessionsHelper
  before do
    driven_by(:rack_test)
  end
  let(:user) { FactoryBot.create(:user) }
  let(:admin) { FactoryBot.create(:admin) }
  scenario "create new user" do
    visit new_user_path
    fill_in 'Name', with: 'aaaa'
    fill_in 'Email', with: 'aaa@aa.com'
    fill_in 'Password', with: 'jjjjjj'
    fill_in 'Password confirmation', with: 'jjjjjj'
    click_on 'create account'
    expect(current_path).to_not eq new_user_path
    expect(page).to have_content 'create your account!'
  end

  scenario 'fail to create user if name is nil' do
    visit new_user_path
    fill_in 'Name', with: nil
    fill_in 'Email', with: 'aaa@aa.com'
    fill_in 'Password', with: 'jjjjjj'
    fill_in 'Password confirmation', with: 'jjjjjj'
    click_on 'create account'
    expect(current_path).to eq new_user_path
    expect(page).to have_content "can't be blank"
  end

  scenario "update account" do
    login(user)
    visit edit_user_path(user)
    fill_in 'Name', with: 'eeee'
    fill_in 'Email', with: user.email
    click_on 'Save Change'
    expect(current_path).to eq user_path(user)
    expect(user.reload.name).to eq 'eeee'
    visit users_path
  end

  scenario "seach user" do
    login(user)
    visit users_path
    fill_in 'user_search', with: "awoooooo"
    click_on 'search'
    within '.searchuser' do
      expect(page).to have_content 'awoooooo'
    end
  end
end
