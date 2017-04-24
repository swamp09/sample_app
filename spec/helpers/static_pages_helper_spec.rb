require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the StaticPagesHelper. For example:
#
# describe StaticPagesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe StaticPagesHelper, type: :helper do
  before  do
    @base_title = "Ruby on Rails Tutorial Sample App"
  end
  describe "GET #home", type: :feature  do
    it "returns http success" do
      visit root_url
      expect(response).to have_http_status(:success)
    end
    it "should have the title Home" do
      visit '/static_pages/home'
      expect(page).to have_title("Home")
    end
  end
    before  do
    @base_title = "Ruby on Rails Tutorial Sample App"
  end


  describe "GET #home", type: :feature  do
    it "returns http success" do
      visit '/static_pages/home'
      expect(response).to have_http_status(:success)
    end
    it "should have the title Home" do
      visit '/static_pages/home'
      expect(page).to have_title("Home | #{@base_title}")
    end
  end

  describe "GET #help",type: :feature do
    it "returns http success" do
      visit '/static_pages/help'
      expect(response).to have_http_status(:success)
    end
    it "should have the title Help" do
      visit '/static_pages/help'
      expect(page).to have_title("Help | #{@base_title}")
    end

  end

  describe "GET #about",type: :feature do
    it "returns http success" do
      visit '/static_pages/about'
      expect(response).to have_http_status(:success)
    end
    it "should have the title About" do
      visit '/static_pages/about'
      expect(page).to have_title("About | #{@base_title}")
    end
  end

  describe "GET #contact",type: :feature do
    it "returns http success" do
      visit '/static_pages/contact'
      expect(response).to have_http_status(:success)
    end
    it "should have the title Contact" do
      visit '/static_pages/contact'
      expect(page).to have_title("Contact | #{@base_title}")
    end
  end
#  pending "add some examples to (or delete) #{__FILE__}"
end
