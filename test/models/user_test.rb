require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should show profile info" do
    user = users(:one)
    assert_equal "Firstname Lastname", user.full_name
    assert_equal "test@email.com", user.email
    assert_equal "Durham, NC", user.current_location
    assert_equal nil, user.website
    assert_equal "github", user.github_profile
  end
end
