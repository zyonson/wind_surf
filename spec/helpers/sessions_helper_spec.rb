require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the SessionsHelper. For example:
#
# describe SessionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe SessionsHelper, type: :helper do
  let(:user) { FactoryBot.create(:user) }
  it 'current_user' do
    log_in user
    expect(helper.current_user).to eq(user)
  end
  it 'current_user nil if not login and remember digest is nil' do
    expect(helper.current_user).to_not eq(user)
  end
  it "current_user returns eq when remember digest is true" do
    remember(user)
    expect(helper.current_user).to eq(user)
    log_out
    expect(helper.current_user).to_not eq(user)
  end
  it "current_user returns nil when remember digest is wrong" do
    remember(user)
    user.update_attribute(:remember_digest, User.digest(User.new_token))
    expect(helper.current_user).to_not eq(user)
  end
end
