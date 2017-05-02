require 'rails_helper'

RSpec.describe 'PasswordResets', type: :request do
  before do
    ActionMailer::Base.deliveries.clear
    @user = create(:michael)
  end
  describe 'password resets' do
    it 'works' do
      visit new_password_reset_path

      expect(page).to have_title('Forgot password')

      post password_resets_path, params: {password_reset: {email: ''}}

      expect(flash.empty?)
      expect(page).to have_title('Forgot password')

      post password_resets_path, params: {password_reset: {email: @user.email}}

      expect(@user.reload.reset_digest).to eq(@user.reset_digest)
      expect(ActionMailer::Base.deliveries.size).to eq(1)
      expect(flash.empty?)

      expect(response).to redirect_to root_url
    end
  end
end
