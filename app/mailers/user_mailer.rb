class UserMailer < ApplicationMailer
  def account_activation(user)
    @user = user

    mail to: user.email, subject: 'Account activation'
  end

  def password_reset(user)
    @user = user

    mail to: user.email, subject: 'Password reset'
  end

  def follower_increase_notification(follower, followed)
    @follower = follower
    @followed = followed

    mail to: @followed.email, subject: 'follower increase!'
  end
end
