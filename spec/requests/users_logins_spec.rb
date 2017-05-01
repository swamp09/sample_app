require 'rails_helper'

RSpec.describe 'UsersLogins', type: :request do
  before do
    @user = create(:michael)
    @other_user = create(:archer)
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

  describe 'redirect index when not logged in' do
    it do
      get users_path

      expect(flash).to_not be_nil
    end
  end

  describe 'redirect edit when not logged in' do
    it do
      get edit_user_path(@user)

      expect(flash).to_not be_nil
    end
  end

  describe 'redirect update when not logged in' do
    subject do
      patch user_path(@user), params: {user: {name: @user.name,
                                              email: @user.email}}
    end
    before do
      login_button(@user)
    end
    it do
      patch user_path(@user), params: {user: {name: @user.name,
                                              email: @user.email}}

      expect(flash).to_not be_nil

      expect(subject).to redirect_to(login_url)
    end
  end

  describe 'redirect edit when not logged in as wrong user' do
    it do
      get edit_user_path(@other_user)

      expect(flash).to_not be_nil
    end
  end

  describe 'redirect update when not logged in as wrong user' do
    subject do
      patch user_path(@other_user), params: {user: {name: @other_user.name,
                                                    email: @other_user.email}}
    end
    before do
      login_button(@other_user)
    end
    it do
      patch user_path(@other_user), params: {user: {name: @other_user.name,
                                                    email: @other_user.email}}

      expect(flash).to_not be_nil

      expect(subject).to redirect_to(login_url)
    end
  end
  describe 'not allow thw admin attribute to be edited via the web' do
    before do
      login_button(@other_user)
    end
    it do
      expect(@other_user.admin?).to be false
      patch user_path(@other_user), params: {user: {password: @other_user.name,
                                                    password_confirmation: @other_user.email,
                                                    admin: true}}
      expect(@other_user.admin?).to be false
    end
  end
end
