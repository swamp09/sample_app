require 'rails_helper'

RSpec.describe 'MicropostsInterface', type: :request do
  before do
    @user = create(:michael)

    login_button @user

    visit root_path
  end

  describe 'should not view for wrong micropost' do
    it do
      micropost = @user.microposts.create(attributes_for(:ants))

      expect(page).to_not have_content(micropost.content)
    end
  end

  describe 'GET RSS feed Micropost' do
    before { get microposts_feed_path }

    subject { response }

    its(:status) { is_expected.to eq(200) }
    its(:body) { is_expected.to match('I just ate an orange') }
    its(:content_type) { is_expected.to eq('application/xml') }
  end
end
