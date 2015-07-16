require 'test_helper'

class EventMailerTest < ActionMailer::TestCase
  setup do
    @user = users(:one)
    @event = events(:one)
  end

  test "new_event" do
    mail = EventMailer.new_event(@user, @event)
    assert_equal "#{@user.full_name}, Event Posted on TIY Forge", mail.subject
    assert_equal ["one@email.com"], mail.to
    assert_equal ["tiy.forge@gmail.com"], mail.from
    assert_match "#{@user.full_name}", mail.body.encoded
    assert_match "#{@event.name}", mail.body.encoded
  end

end
