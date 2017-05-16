require 'rails_helper'

RSpec.describe 'UsersIndices', type: :request do
  before do
    20.times { FactoryGirl.create(:user) }
  end

  describe 'GET' do
    context 'users/index' do
      it '全てのユーザーの情報がjson形式で返ってくる' do
        get api_v1_users_path

        expect(response.status).to eq(200)

        json = JSON.parse(response.body)

        expect(json.size).to eq User.count

        expect(json[0]['name']).to eq User.first.name
        expect(json[1]['id']).to eq User.second.id
      end
    end

    context 'user/show' do
      it '特定のユーザーの情報がjson形式で帰ってくる' do
        get api_v1_user_path User.first.id

        expect(response.status).to eq(200)

        json = JSON.parse(response.body)

        expect(json['id']).to eq User.first.id
        expect(json['name']).to eq User.first.name
      end
    end
  end
end
