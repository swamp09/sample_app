require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'account_activation' do
    before { @user = create(:michael) }
    let(:mail) { UserMailer.account_activation(@user) }

    it 'renders the headers' do
      @user.activation_token = User.new_token

      expect(mail.subject).to eq('Account activation')
      expect(mail.to).to eq([@user.email])
      expect(mail.from).to eq(['from@example.com'])
      expect(mail.body.encoded).to match(@user.name)
      expect(mail.body.encoded).to match(@user.activation_token)
      expect(mail.body.encoded).to match(CGI.escape(@user.email))
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('Hi')
    end
  end

  describe 'password_reset' do
    it 'renders the headers' do
      user = create(:michael)
      user.reset_token = User.new_token

      mail = UserMailer.password_reset(user)

      expect(mail.subject).to eq('Password reset')
      expect(mail.to).to eq([user.email])
      expect(mail.body.encoded).to match(user.reset_token)
      expect(mail.body.encoded).to match(CGI.escape(user.email))
    end
  end

  describe 'follower_increase_notification' do
    context 'followerが増えた時' do
      context 'フォローされたユーザーのnotification_optionがtrue' do
        it 'メールで通知する' do
          user = create(:michael)
          other = create(:archer)

          expect(user.notification_option).to be_truthy

          mail = UserMailer.follower_increase_notification(other, user)

          expect(mail.subject).to eq('follower increase!')
          expect(mail.to).to eq([user.email])
          expect(mail.from).to eq(['from@example.com'])
          expect(mail.body.encoded).to match(other.name)
        end
      end

      context 'フォローされたユーザーのnotification_optionがfalse' do
        it 'メールで通知しない' do
          user = create(:michael)
          user.notification_option = false

          other = create(:archer)

          expect(user.notification_option).to be_falsey

          mail = UserMailer.follower_increase_notification(other, user)

          expect(mail.to.nil?).to be_truthy
        end
      end
    end
  end
end
