require 'rails_helper'
RSpec.describe "Favorites", type: :system do
  include SessionsHelper
  before do
    driven_by(:rack_test)
  end
  let(:user) { FactoryBot.create(:user) }
  let!(:store) { FactoryBot.create(:store) }

  #  scenario 'favorite ' do
  #   login(user)
  #    visit store_path(store.id)
  #    find(".fa-regular").click
  #    expect(page).to have_css ".fa-solid"
  #  end
  #  let!(:favorite) { FactoryBot.create(:favorite) }
  #  scenario 'destroy favorite' do
  #    login(favorite.user)
  #    visit store_path(favorite.store.id)
  #    find(".fa-solid").click
  #    expect(page).to have_content "お気に入り削除しました"
  #  end
end
