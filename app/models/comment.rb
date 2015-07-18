class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  after_create :send_comment_email

  validates_presence_of :body

  private def send_comment_email
    # if self.commentable.user.get_comment_email
    #   UserMailer.new_comment(self.commentable.user, self).deliver_now
    # end
  end
end
