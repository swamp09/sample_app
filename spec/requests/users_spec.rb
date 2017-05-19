require 'rails_helper'

RSpec.describe 'Users', type: :request do
  before { create_list(:user, 20) }
  let(:user) { User.first }

  let(:params) { {name: 'Foo bar', email: 'foo@bar.com', password: 'foobar', password_confirmation: 'foobar'} }
  let(:invalid_params) { {name: 'Foo bar', email: 'foo@bar.com', password: 'foobar', password_confirmation: 'barbaz'} }

  describe 'GET /api/v1/users' do
    before { get api_v1_users_path }

    specify { expect(response.status).to eq(200) }

    subject { JSON.parse(response.body)[0] }
    its(['id']) { is_expected.to eq user.id }
    its(['name']) { is_expected.to eq user.name }
  end

  describe 'GET /api/v1/users/:id' do
    before { get api_v1_user_path user.id }

    specify { expect(response.status).to eq(200) }

    subject { JSON.parse(response.body) }
    its(['id']) { is_expected.to eq user.id }
    its(['name']) { is_expected.to eq user.name }
  end

  describe 'POST /api/v1/users' do
    context 'パラメータが正常な場合' do
      before { post api_v1_users_path, params: params }

      specify { expect(response.status).to eq(201) }

      subject { JSON.parse(response.body) }
      its(['name']) { is_expected.to eq 'Foo bar' }
      its(['email']) { is_expected.to eq 'foo@bar.com' }

      subject { User.last }
      its(:name) { is_expected.to eq('Foo bar') }
      its(:email) { is_expected.to eq('foo@bar.com') }
    end

    context '正常でない場合' do
      before { post api_v1_users_path, params: invalid_params }

      specify { expect(response.status).to eq(422) }
    end
  end

  describe 'PATCH /api/v1/users/:id' do
    context 'パラメータが正常な場合' do
      before { patch api_v1_user_path user, params: params }

      specify { expect(response.status).to eq(200) }

      subject { JSON.parse(response.body) }
      its(['name']) { is_expected.to eq 'Foo bar' }
      its(['email']) { is_expected.to eq 'foo@bar.com' }

      before { user.reload }
      subject { user }
      its(:name) { is_expected.to eq('Foo bar') }
      its(:email) { is_expected.to eq('foo@bar.com') }
    end

    context '正常でない場合' do
      before { patch api_v1_user_path user, params: invalid_params }
      specify { expect(response.status).to eq(422) }
    end
  end

  describe 'DELETE /api/v1/users/:id' do
    let!(:delete_user) { user }
    before { delete api_v1_user_path user }
    specify '特定のユーザーを削除する' do
      expect(delete_user).to_not eq User.first
    end
  end
end
