module LoginSupport
  def login(user)
    visit login_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on "Log in"
  end
end
