require 'rails_helper'

RSpec.describe 'Sessions', type: :system do
  include SessionsHelper
  let!(:user) { FactoryBot.create(:user) }
  before do
    driven_by(:rack_test)
  end

  scenario 'login' do
    visit login_path
    expect(current_path).to eq login_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    expect(current_path).to eq user_path(user.id)
    expect(page).to have_content('login success')
  end
  scenario 'logout' do
    login(user)
    click_on 'logout'
    expect(current_path).to eq login_path
    expect(page).to have_content('logout')
  end
end
