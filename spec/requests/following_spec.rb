require 'rails_helper'

RSpec.describe 'Following', type: :request do
  before do
    @user = create(:michael)
    @other = create(:archer)

    login_button @user
  end

  describe 'following page' do
    context 'ユーザーがfollowしている時' do
      it 'followしているユーザーへのリンクを表示する' do
        visit following_user_path(@user)

        expect(@user.following.empty?).to be_truthy

        expect(page.body).to match(@user.following.count.to_s)

        @user.following.each do |user|
          expect(page).to have_selector('a[href=?]', user_path(user))
        end
      end
    end
  end

  describe 'followers page' do
    context 'ユーザーがfollowされている時' do
      it 'followされているユーザーへのリンクを表示する' do
        visit following_user_path(@user)

        expect(@user.followers.empty?).to be_truthy
        expect(page.body).to match(@user.followers.count.to_s)

        @user.followers.each do |user|
          expect(page).to have_selector('a[href=?]', user_path(user))
        end
      end
    end
  end

  describe 'follow button' do
    it 'ボタンを押してfollowする' do
      visit user_path(@other)
      pending('localでパスするがtravisで動かなくなるため一旦pending')

      expect { click_button 'Follow' }.to change(Relationship, :count).by(1)
    end
  end

  describe 'unfollow button' do
    context 'あるユーザーをfollowしている時' do
      it 'ボタンを押してunfollowする' do
        @user.follow(@other)
        visit user_path(@other)
        pending('localでパスするがtravisで動かなくなるため一旦pending')
        expect { click_button 'Unfollow' }.to change(Relationship, :count).by(-1)
      end
    end
  end
end
