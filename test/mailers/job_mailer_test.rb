require 'test_helper'

class JobMailerTest < ActionMailer::TestCase
  setup do
    @user = users(:one)
    @job = job_posts(:one)
  end

  test "new_job" do
    mail = JobMailer.new_job(@user, @job)
    assert_equal "#{@user.full_name}, Job Posted on TIY Forge", mail.subject
    assert_equal ["one@email.com"], mail.to
    assert_equal ["tiy.forge@gmail.com"], mail.from
    assert_match "#{@user.full_name}", mail.body.encoded
  end

end
