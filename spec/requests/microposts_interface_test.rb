require 'rails_helper'

RSpec.describe 'MicropostsInterface', type: :request do
  before do
    @user = create(:michael)
    @micropost = @user.microposts.create(attributes_for(:orange))

    login_button @user

    visit root_path
  end

  describe 'should redirect create when not logeed in' do
    it 'should create a micropost' do
      fill_in 'micropost_content', with: 'Lorem ipsum'

      expect { click_button 'Post' }.to change(Micropost, :count).by(1)
    end
  end

  describe 'should redirect destroy when not logeed in' do
    it 'should delete a micropost' do
      expect { click_link 'delete' }.to change(Micropost, :count).by(-1)
    end
  end

  describe 'should not view for wrong micropost' do
    it do
      micropost = @user.microposts.create(attributes_for(:ants))

      expect(page).to_not have_content(micropost.content)
    end
  end
end
