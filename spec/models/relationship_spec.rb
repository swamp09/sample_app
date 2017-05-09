require 'rails_helper'

RSpec.describe Relationship, type: :model do
  before do
    @relationship = Relationship.new(follower_id: create(:michael).id, followed_id: create(:archer).id)
  end

  describe 'should be valid' do
    it do
      expect(@relationship.valid?).to be_truthy
    end
  end

  describe 'should require' do
    it 'a follower' do
      @relationship.follower_id = nil
      expect(@relationship.valid?).to be_falsey
    end

    it 'a followed' do
      @relationship.followed_id = nil
      expect(@relationship.valid?).to be_falsey
    end
  end
end
