require 'rails_helper'

RSpec.describe 'Users', type: :request do
  before { create_list(:user, 20) }

  let(:user) { User.first }

  let(:params) { {name: 'Foo bar', email: 'foo@bar.com', password: 'foobar', password_confirmation: 'foobar'} }
  let(:invalid_params) { {name: 'Foo bar', email: 'foo@bar.com', password: 'foobar', password_confirmation: 'barbaz'} }

  let(:headers) do
    {
      HTTP_ACCEPT: 'application/json',
      HTTP_AUTHORIZATION: ActionController::HttpAuthentication::Basic.encode_credentials('user', 'pass')
    }
  end

  describe 'GET /api/v1/users ユーザー一覧を取得する' do
    before { get api_v1_users_path, headers: headers }

    subject { JSON.parse(response.body)[0] }

    its(['id']) { is_expected.to eq user.id }
    its(['name']) { is_expected.to eq user.name }

    specify { expect(response.status).to eq(200) }
  end

  describe 'GET /api/v1/users/:id 特定のユーザーを取得する' do
    before { get api_v1_user_path(user.id), headers: headers }

    subject { JSON.parse(response.body) }

    its(['id']) { is_expected.to eq user.id }
    its(['name']) { is_expected.to eq user.name }

    specify { expect(response.status).to eq(200) }
  end

  describe 'POST /api/v1/users 新規ユーザーを作成する' do
    context 'パラメータが正常な場合' do
      before { post api_v1_users_path, params: params, headers: headers }

      describe 'JSONが返ってくる' do
        subject { JSON.parse(response.body) }

        its(['name']) { is_expected.to eq 'Foo bar' }
        its(['email']) { is_expected.to eq 'foo@bar.com' }

        specify { expect(response.status).to eq(201) }
      end

      describe 'DBに反映されている' do
        subject { User.last }

        its(:name) { is_expected.to eq('Foo bar') }
        its(:email) { is_expected.to eq('foo@bar.com') }
      end
    end

    context '正常でない場合' do
      before { post api_v1_users_path, params: invalid_params, headers: headers }

      specify { expect(response.status).to eq(422) }
    end
  end

  describe 'PATCH /api/v1/users/:id 特定のユーザーを変更する' do
    context 'パラメータが正常な場合' do
      before { patch "/api/v1/users/#{user.id}", params: params, headers: headers }

      describe 'JSONが返ってくる' do
        subject { JSON.parse(response.body) }

        its(['name']) { is_expected.to eq 'Foo bar' }
        its(['email']) { is_expected.to eq 'foo@bar.com' }

        specify { expect(response.status).to eq(200) }
      end

      describe 'DBに反映されている' do
        before { user.reload }

        subject { user }

        its(:name) { is_expected.to eq('Foo bar') }
        its(:email) { is_expected.to eq('foo@bar.com') }
      end
    end

    context '正常でない場合' do
      before { patch "/api/v1/users/#{user.id}", params: invalid_params, headers: headers }

      specify { expect(response.status).to eq(422) }
    end
  end

  describe 'DELETE /api/v1/users/:id ' do
    let!(:delete_user) { user }

    before { delete "/api/v1/users/#{user.id}", headers: headers }

    specify '特定のユーザーを削除する' do
      expect(delete_user).to_not eq User.first
    end
  end
end
