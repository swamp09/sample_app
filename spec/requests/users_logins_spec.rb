require 'rails_helper'

RSpec.describe 'UsersLogins', type: :request do
  def log_in_as(user, password: 'password', remember_me: '1')
    post login_path, params: {session: {email: user.email,
                                        password: password,
                                        remember_me: remember_me}}
  end

  before do
    @user = FactoryGirl.create(:michael)
  end

  describe 'GET /users_logins' do
    it 'with invalid infomation' do
      visit login_path

      click_button 'Log in'

      expect(page).to have_title('Log in | Ruby on Rails Tutorial Sample App')

      expect(page).to have_selector('div.alert.alert-danger', text: 'Invalid')

      visit root_path

      expect(page).to_not have_selector('div.alert.alert-danger', text: 'Invalid')
    end
  end

  describe 'login valid infomation' do
    before do
      visit login_path

      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password

      click_button 'Log in'
    end
    it 'infomation valid' do
      expect(page).to have_title(@user.name)
    end
  end

  describe 'logout' do
    before do
      visit login_path

      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password

      click_button 'Log in'
    end
    it 'followed by logout' do
      expect(page).to have_title(@user.name)

      click_link 'Log out'

      expect(page).to have_title('Home')

      delete logout_path

      expect(page).to have_title('Home')
    end
  end

  describe 'POST #create' do
    let(:valid_parameters) do
      {email: @user.email, password: @user.password}
    end

    it 'saves the user ID to the session object' do
      visit login_path

      post login_path, session: valid_parameters

      expect(session[:user_id]).to_not be nil
    end
  end

  describe 'remembering' do
    it 'log in with remembering' do
      log_in_as(@user, remember_me: '1')

      expect(cookies['remember_token']).to_not be nil
    end

    it 'login without remembering' do
      log_in_as(@user, remember_me: '0')

      expect(cookies['remember_token']).to be nil
    end
  end
end
