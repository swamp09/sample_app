require 'rails_helper'

RSpec.describe Micropost, type: :model do
  before do
    @user = create(:michael)

    @micropost = @user.microposts.build(content: 'lorem ipsum')
  end

  describe 'should be valid' do
    it do
      expect(@micropost.valid?)
    end
  end

  describe 'user id should be present' do
    it do
      @micropost.user_id = nil
      expect(!@micropost.valid?)
    end
  end

  describe 'present' do
    it 'content should be present' do
      @micropost.content = ' '
      expect(!@micropost.valid?)
    end

    it 'content should be at most 140 characters' do
      @micropost.content = 'a' * 141
      expect(!@micropost.valid?)
    end
  end

  describe 'order should be most recent first' do
    it do
      expect(@user.microposts.create(attributes_for(:most_recent))).to eq(Micropost.first)
    end
  end
end
