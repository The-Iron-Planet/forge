require 'test_helper'

class JobMailerTest < ActionMailer::TestCase
  test "new_job" do
    mail = JobMailer.new_job
    assert_equal "New job", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
