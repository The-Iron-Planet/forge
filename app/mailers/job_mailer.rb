class JobMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.job_mailer.new_job.subject
  #
  def new_job(user, job)
    @user = user
    @job = job
    mail(to: "#{@user.full_name} <#{@user.email}>", subject: "#{@user.full_name}, Job Posted on TIY Forge")
  end
end
