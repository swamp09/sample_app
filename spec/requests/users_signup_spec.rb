require 'rails_helper'

RSpec.describe "UsersSignup", type: :request do
  describe "GET /users_signup" do

    before do
      visit signup_path
    end

    subject {page}


    let(:submit) { 'Create my account' }

    it 'with invalid informaion' do
      expect { click_button submit }.to_not change(User, :count)
    end

    describe "with valid information" do
      before do
        fill_in "Name", with: "Example User"
        fill_in "Email", with: "user@example.com"
        fill_in "Password", with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "with valid information" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end
end
