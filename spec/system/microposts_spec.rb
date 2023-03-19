require 'rails_helper'

RSpec.describe 'Micropost', type: :system do
  include SessionsHelper
  before do
    driven_by(:rack_test)
  end
  let!(:store) { FactoryBot.create(:store) }
  let(:admin) { FactoryBot.create(:admin) }
  let(:user) { FactoryBot.create(:user) }
  let(:user1) { FactoryBot.create(:user) }
  let(:micropost) { FactoryBot.crete(:micropost) }

  scenario "comment faild if not login" do
    visit store_path(store.id)
    fill_in "Title", with: 'uu'
    fill_in "Content", with: 'yy'
    click_on "コメントする"
    expect(page).to_not have_content "コメントを投稿しました"
  end

  scenario "micro" do
    login(user)
    visit store_path(store.id)
    fill_in "Title", with: 'uu'
    fill_in "Content", with: 'yy'
    click_on "コメントする"
    expect(current_path).to eq store_path(store)
  end

  scenario "user can't comment same store again" do
    login(user)
    visit store_path(store.id)
    fill_in "Title", with: 'uu'
    fill_in "Content", with: 'yy'
    click_on "コメントする"
    expect(current_path).to eq store_path(store)
    fill_in "Title", with: 'ywuccccjjc'
    fill_in "Content", with: 'yy'
    click_on "コメントする"
    expect(page).to_not have_content 'ywuccccjjc'
  end

  scenario "if other user delete comment, faild" do
    micropost = FactoryBot.create(:micropost)
    login(user1)
    visit store_path(micropost.store_id)
    click_on "削除"
    expect(page).to_not have_content "コメントを削除しました"
  end

  scenario "user can delete own comment" do
    micropost = FactoryBot.create(:micropost)
    login(micropost.user)
    visit store_path(micropost.store_id)
    click_on "削除"
    expect(page).to have_content "コメントを削除しました"
  end
end
