require 'rails_helper'

RSpec.describe "UsersLogins", type: :request do
  before do
    @user = FactoryGirl.create(:michael)
  end

  describe "GET /users_logins" do
    it "with invalid infomation" do
      visit login_path

      click_button "Log in"

      expect(page).to have_title('Log in | Ruby on Rails Tutorial Sample App')

      expect(page).to have_selector('div.alert.alert-danger', text: 'Invalid')

      visit root_path

      expect(page).to_not have_selector('div.alert.alert-danger', text: 'Invalid')
    end
  end

  describe "login valid infomation" do
    before do
      visit login_path

      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password

      click_button "Log in"
    end
    it "infomation valid" do
      expect(page).to have_title(@user.name)
    end
  end

  describe 'logout' do
    before do
      visit login_path

      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password

      click_button "Log in"
    end
    it 'followed by logout' do
      expect(page).to have_title(@user.name)
      click_link "Log out"

      expect(page).to have_title("Home")
    end

  end
end
