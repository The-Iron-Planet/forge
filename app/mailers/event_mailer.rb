class EventMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.event_mailer.new_event.subject
  #
  def new_event(user, event)
    @user = user
    @event = event
    mail(to: "#{@user.full_name} <#{@user.email}>", subject: "#{@user.full_name}, Event Posted on TIY Forge")
  end
end
