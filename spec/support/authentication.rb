def sign_in(user)
  visit new_session_url
  fill_in "Enter email address or password", with: user.email
  fill_in "Password", with: user.password
  click_button "Sign In"
end
