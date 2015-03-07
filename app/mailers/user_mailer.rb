class UserMailer < ActionMailer::Base
  def send_password_reset_mail(user)
    @user = user
    mail(to: @user.email, subject: 'Password Reset')
  end

  def send_confirmation_mail(user)
    @user = user
    mail(to: @user.email, subject: 'Confirm Account')
  end
end