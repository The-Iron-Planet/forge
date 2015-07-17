class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_created.subject
  #
  def account_created(user)
    @user = user
    mail(to: "#{@user.full_name} <#{@user.email}>", subject: "#{@user.full_name}, TIY Forge Account Created")
  end

  def new_event(user, event)
    @user = user
    @event = event
    mail(to: "#{@user.full_name} <#{@user.email}>", subject: "#{@user.full_name}, Event Posted on TIY Forge")
  end

  def new_job(user, job)
    @user = user
    @job = job
    mail(to: "#{@user.full_name} <#{@user.email}>", subject: "#{@user.full_name}, Job Posted on TIY Forge")
  end

  def new_resource(user, resource)
    @user = user
    @resource = resource
    mail(to: "#{@user.full_name} <#{@user.email}>", subject: "#{@user.full_name}, Resource Posted on TIY Forge")
  end

  def new_comment(user, comment)
    @user = user
    @comment = comment
    mail(to: "#{@user.full_name} <#{@user.email}>", subject: "#{@user.full_name}, Comment Posted on TIY Forge")
  end
end
