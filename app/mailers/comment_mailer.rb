class CommentMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.comment_mailer.new_comment.subject
  #
  def new_comment(user, comment)
    @user = user
    @comment = comment
    mail(to: "#{@user.full_name} <#{@user.email}>", subject: "#{@user.full_name}, Comment Posted on TIY Forge")
  end
end
