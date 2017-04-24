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
    before {visit root_path}
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
    it "should have the title Home" do
      expect(page).to have_title("Ruby on Rails Tutorial Sample App")
    end
    it 'current path is root_path' do
      expect(current_path).to eq root_path
    end
    it "layout links" do
      expect(page).to have_selector(:css, 'a[href="/"]')
      expect(page).to have_selector(:css, 'a[href="/help"]')
      expect(page).to have_selector(:css, 'a[href="/about"]')
      expect(page).to have_selector(:css, 'a[href="/contact"]')
      expect(page).to have_selector(:css, 'a[href="/signup"]')
    end
  end



  describe "GET #home", type: :feature  do
    before {visit help_path}
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
    it "should have the title Home" do
      expect(page).to have_title("Help | Ruby on Rails Tutorial Sample App")
    end
  end

  describe "GET #about",type: :feature do
    before {visit about_path}
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
    it "should have the title About" do
      expect(page).to have_title("About | Ruby on Rails Tutorial Sample App")
    end
  end

  describe "GET #contact",type: :feature do
    before {visit contact_path}
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
    it "should have the title Contact" do
      expect(page).to have_title("Contact | Ruby on Rails Tutorial Sample App")
    end
    it 'full title contact' do
      expect(page).to have_title full_title("Contact")
    end
  end
end
#  pending "add some examples to (or delete) #{__FILE__}"