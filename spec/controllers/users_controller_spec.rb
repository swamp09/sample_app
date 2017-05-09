require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before do
    @user = create(:michael)
    @other_user = create(:archer)
  end

  describe '#following' do
    context 'ログインしていない時' do
      it 'ログインページへ' do
        visit following_user_path(@user)
        expect(current_path).to eq(login_path)
      end
    end
  end

  describe '#followers' do
    context 'ログインしていない時' do
      it 'ログインページへ' do
        visit followers_user_path(@user)
        expect(current_path).to eq(login_path)
      end
    end
  end
end
