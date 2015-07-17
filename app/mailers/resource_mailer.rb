class ResourceMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.resource_mailer.new_resource.subject
  #
  def new_resource(user, resource)
    @user = user
    @resource = resource
    mail(to: "#{@user.full_name} <#{@user.email}>", subject: "#{@user.full_name}, Resource Posted on TIY Forge")
  end

end
