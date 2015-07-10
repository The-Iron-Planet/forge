class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_created.subject
  #

  def send_test_email
    mail(to: "jmbuscemi@gmail.com", subject: "This Worked!")
  end

  def account_created(user)
    @user = user
    mail(to: "#{@user.full_name} <#{@user.email}>", subject: "#{@user.full_name}, TIY Forge Account Created")
  end
end
