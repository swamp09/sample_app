require 'rails_helper'

RSpec.describe RelationshipsController, type: :controller do
  describe 'Relationships' do
    describe '#create' do
      it 'should require logged_in user' do
        expect { post :create }.to change(Relationship, :count).by(0)
      end
    end

    describe '#destroy' do
      it 'should require logged_in user' do
        @relationship = Relationship.new(follower_id: create(:michael).id, followed_id: create(:lana).id)
        @relationship.save
        expect { delete :destroy, id: @relationship }.to change(Relationship, :count).by(0)
      end
    end
  end
end
