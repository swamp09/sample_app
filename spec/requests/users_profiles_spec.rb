require 'rails_helper'

RSpec.describe 'UsersProfiles', type: :request do
  include ApplicationHelper

  before do
    @user = create(:michael)
    30.times { @user.microposts.create(attributes_for(:micropost)) }
  end

  describe 'profile display' do
    it do
      visit user_path(@user)

      expect(page).to have_title(full_title(@user.name))
      expect(page).to have_selector('h1', text: @user.name)
      expect(page).to have_css('h1>img.gravatar')

      expect(page.body).to match(@user.microposts.count.to_s)
      expect(page).to have_css('img.gravatar')

      @user.microposts.page.each do |micropost|
        expect(page.body).to match(micropost.content)
      end
    end
  end
end
