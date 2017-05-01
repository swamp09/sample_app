RSpec::Matchers.define :have_error_message do |_message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-error', text: 'Invalid')
  end
end

def is_logged_in?
  !session[:user_id].nil?
end

def log_in_as(user, remember_me: '1')
  post login_path, params: {session: {
    email: user.email,
    password: user.password,
    remember_me: remember_me
  }}
end

def login_button(user)
  visit login_path

  fill_in 'Email', with: user.email
  fill_in 'Password', with: user.password

  click_button 'Log in'

  cookies[:remember_token] = user.remember_token
end
