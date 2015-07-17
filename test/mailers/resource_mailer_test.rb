require 'test_helper'

class ResourceMailerTest < ActionMailer::TestCase
  setup do
    @user = users(:one)
    @resource = resources(:one)
  end

  test "new_resource" do
    mail = ResourceMailer.new_resource(@user, @resource)
    assert_equal "#{@user.full_name}, Resource Posted on TIY Forge", mail.subject
    assert_equal ["one@email.com"], mail.to
    assert_equal ["tiy.forge@gmail.com"], mail.from
    assert_match "Rails Resource", mail.body.encoded
  end

end
