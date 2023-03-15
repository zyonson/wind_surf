require 'rails_helper'

RSpec.describe 'Store', type: :system do
  include SessionsHelper
  before do
    driven_by(:rack_test)
  end
  let!(:store) { FactoryBot.create(:store) }
  let(:admin) { FactoryBot.create(:admin) }
  let(:user) { FactoryBot.create(:user) }

  scenario "delete store if admin user" do
    login(admin)
    visit stores_path
    click_on "gg"
    expect(current_path).to eq store_path(store.id)
  end

  scenario "delete store if admin user" do
    login(admin)
    visit stores_path
    click_on "delete"
    expect(page).to have_content 'delete store'
  end

  scenario " admin user only create store" do
    login(admin)
    visit new_store_path
    expect(current_path).to eq new_store_path
  end
  scenario " admin user only create store" do
    login(user)
    visit new_store_path
    expect(current_path).to eq stores_path
  end
  scenario "store create is fail if phone number is invalid" do
    login(admin)
    visit new_store_path
    fill_in 'Store name', with: 'usss'
    fill_in 'Address', with: "sss"
    fill_in 'Phone number', with: '000'
    click_on 'create'
    expect(page).to have_content 'Phone number is invalid'
  end
  scenario 'store create' do
    login(admin)
    visit new_store_path
    fill_in 'Store name', with: 'usss'
    fill_in 'Address', with: "sss"
    fill_in 'Phone number', with: '09090909090'
    fill_in 'Boat house', with: 'あり'
    fill_in 'Price', with: '111'
    fill_in 'Day', with: '月曜日'
    fill_in 'Time', with: '10:00~13:00'
    fill_in 'Prefecture', with: '大分県'
    click_on 'create'
    expect(current_path).to eq stores_path
    expect(page).to have_content('usss')
  end
  scenario 'search' do
    login(user)
    visit stores_path
    fill_in 'title_search', with: 'gg'
    expect(page).to have_content('gg')
  end
end
