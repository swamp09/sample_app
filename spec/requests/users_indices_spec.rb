require 'rails_helper'

RSpec.describe "UsersIndices", type: :request do
  let(:user) {create(:user)}

  before(:all) {30.times{create(:user)}}
  after(:all)  {User.delete_all }

  before(:each) do
    @admin = create(:michael)
    @non_admin = create(:archer)

    login_button user

    visit users_path
  end

  describe "index" do
    it "including pagination" do
      login_button @admin

      visit users_path

      expect(page).to have_title("All users")
      expect(page).to have_selector("nav.pagination")
      if  user == @admin
        expect(page).to have_selector('a', :href => users_path(user),:text => "delete")
      end
      expect { click_link('delete') }.to change(User, :count).by(-1)
    end

    it "index as non_admin" do
      login_button(@non_admin)

      visit users_path

      expect(page).to_not have_selector('a',:text => "delete")
    end
  end
end
