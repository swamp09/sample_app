require 'rails_helper'

RSpec.describe 'UsersSignup', type: :request do
  describe 'GET /users_signup' do
    before do
      ActionMailer::Base.deliveries.clear
      visit signup_path
    end

    subject { page }

    let(:submit) { 'Create my account' }

    it 'with invalid informaion' do
      expect { click_button submit }.to_not change(User, :count)
    end

    describe 'valid signup information with account activation' do
      before do
        fill_in 'Name', with: 'Example User'
        fill_in 'Email', with: 'user@example.com'
        fill_in 'Password', with: 'password'
        fill_in 'Password confirmation', with: 'password'
      end
      it do
        expect { click_button submit }.to change(User, :count).by(+1)
        expect(ActionMailer::Base.deliveries.size).to eq(1)

        user = create(:michael)

        expect(user.activated?)

        log_in_as(user)
      end
    end
  end
end
