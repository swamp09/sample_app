require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.new(name: 'Example User', nickname: 'example', email: 'user@example.com', password: 'foobar', password_confirmation: 'foobar')
    @michael = create(:michael)
    @archer = create(:archer)
    @lana = create(:lana)
  end

  describe 'instance variables' do
    subject { @user }

    it { expect respond_to :name }
    it { expect respond_to :email }
  end

  describe 'when name is not present' do
    before { @user.name = ' ' }

    it { expect(@user).to_not be_valid }
  end

  describe 'when name is not present' do
    before { @user.email = ' ' }

    it { expect(@user).to_not be_valid }
  end

  describe 'name be too long' do
    before { @user.name = 'a' * 51 }

    it { expect(@user).to_not be_valid }
  end

  describe 'email be too long' do
    before { @user.email = 'a' * 244 + '@example.com' }

    it { expect(@user).to_not be_valid }
  end

  describe 'email validation should accept valid addresses' do
    it 'should be valid' do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                             foo@bar_baz.com foo@bar+baz.com]

      invalid_addresses.each do |invalid_address|
        @user.email = invalid_address
        expect(@user).to_not be_valid, "#{invalid_address.inspect} is not correct"
      end
    end
  end

  describe 'email addresses should be unique' do
    it 'unique' do
      duplicate_user = @user.dup
      @user.save

      expect(duplicate_user).to_not be_valid
    end

    it 'address saved as lower-case' do
      mixed_case_email = 'Foo@ExAMPle.CoM'
      @user.email = mixed_case_email
      @user.save

      expect(mixed_case_email.downcase).to eq(@user.reload.email)
    end
  end

  describe 'password' do
    it 'password should be present (nonblank)' do
      @user.password = @user.password_confirmation = ' ' * 6

      expect(@user).to_not be_valid
    end

    it 'password should have a minimum length' do
      @user.password = @user.password_confirmation = 'a' * 5

      expect(@user).to_not be_valid
    end
  end

  describe 'authenticated?' do
    it 'user with nil digest' do
      expect @user.authenticated?(:remember, '')
    end
  end

  describe 'associated microposts should be destroyed' do
    it do
      @user.save
      @user.microposts.create!(content: 'Lorem ipsum')

      expect { @user.destroy }.to change(Micropost, :count).by(-1)
    end
  end

  describe '#follow, #unfollow' do
    context 'AユーザーがBユーザーをfollowしていない時' do
      it 'AがBをfollowした後、unfollowする' do
        expect(@michael.following?(@archer)).to be_falsey

        @michael.follow(@archer)

        expect(@michael.following?(@archer)).to be_truthy
        expect(@archer.followers.include?(@michael)).to be_truthy

        @michael.unfollow(@archer)

        expect(@michael.following?(@archer)).to be_falsey
      end
    end
  end

  describe 'feed' do
    context 'AユーザーはfollowしているBと、していないCがいる' do
      it 'followしているユーザーのmicropostが表示されている' do
        @lana.microposts.each do |post_following|
          expect(michael.feed.include?(post_following)).to be_truthy
        end
      end

      it '自分自身のmicropostが表示されている' do
        @michael.microposts.each do |post_self|
          expect(@michael.feed.include?(post_self)).to be_truthy
        end
      end

      it 'followしていないユーザーのmicropostは表示されない' do
        @archer.microposts.each do |post_unfollwed|
          expect(@michael.feed.include?(post_unfollwed)).to be_falsey
        end
      end
    end
  end
end
