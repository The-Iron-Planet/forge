require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "mail sends" do
    @user = users(:one)
    mail = UserMailer.account_created(@user)

    assert_match "TIY", mail.subject
    assert_equal ["one@email.com"], mail.to
    assert_equal ["tiy.forge@gmail.com"], mail.from
    assert_match "Forge", mail.body.encoded
  end

end
