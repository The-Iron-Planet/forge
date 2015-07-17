# Preview all emails at http://localhost:3000/rails/mailers/resource_mailer
class ResourceMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/resource_mailer/new_resource
  def new_resource
    ResourceMailer.new_resource
  end

end
