module LoginSupport
  def login(user)
    visit login_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on "Log in"
  end

  def log_in_as(user, remember_me: '1')
    post login_path, params: { session: { email: user.email,
                                          password: user.password,
                                          remember_me: } }
  end
end
