require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  setup do
    @user = users(:one)
    @resource = resources(:one)
    @job = job_posts(:one)
    @event = events(:one)
    @comment = comments(:one)
    @user2 = users(:two)
  end

  test "mail sends" do
    mail = UserMailer.account_created(@user)
    assert_match "TIY", mail.subject
    assert_equal ["one@email.com"], mail.to
    assert_equal ["tiy.forge@gmail.com"], mail.from
    assert_match "Forge", mail.body.encoded
  end

  test "new_resource" do
    mail = UserMailer.new_resource(@user, @resource)
    assert_equal "#{@user.full_name}, Resource Posted on TIY Forge", mail.subject
    assert_equal ["one@email.com"], mail.to
    assert_equal ["tiy.forge@gmail.com"], mail.from
    assert_match "Rails Resource", mail.body.encoded
  end

  test "new_job" do
    mail = UserMailer.new_job(@user, @job)
    assert_equal "#{@user.full_name}, Job Posted on TIY Forge", mail.subject
    assert_equal ["one@email.com"], mail.to
    assert_equal ["tiy.forge@gmail.com"], mail.from
    assert_match "#{@user.full_name}", mail.body.encoded
  end

  test "new_event" do
    mail = UserMailer.new_event(@user, @event)
    assert_equal "#{@user.full_name}, Event Posted on TIY Forge", mail.subject
    assert_equal ["one@email.com"], mail.to
    assert_equal ["tiy.forge@gmail.com"], mail.from
    assert_match "#{@user.full_name}", mail.body.encoded
    assert_match "#{@event.title}", mail.body.encoded
  end

  test "new_comment" do
    mail = UserMailer.new_comment(@comment.commentable.user, @comment)
    assert_equal "#{@user.full_name}, Comment Posted on TIY Forge", mail.subject
    assert_equal ["#{@user.email}"], mail.to
    assert_equal ["tiy.forge@gmail.com"], mail.from
    assert_match "#{@user.full_name}, #{@user2.full_name} posted a comment on your #{@comment.commentable_type}", mail.body.encoded
  end

end
