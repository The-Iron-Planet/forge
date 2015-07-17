require 'test_helper'

class CommentMailerTest < ActionMailer::TestCase
  setup do
    @comment = comments(:one)
    @user1 = users(:one)
    @user2 = users(:two)
  end

  test "new_comment" do
    mail = CommentMailer.new_comment(@comment.commentable.user, @comment)
    assert_equal "#{@user1.full_name}, Comment Posted on TIY Forge", mail.subject
    assert_equal ["#{@user1.email}"], mail.to
    assert_equal ["tiy.forge@gmail.com"], mail.from
    assert_match "#{@user1.full_name}, #{@user2.full_name} posted a comment on your #{@comment.commentable_type}", mail.body.encoded
  end

end
