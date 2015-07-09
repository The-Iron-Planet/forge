require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @course = courses(:one)
    @durham = campuses(:one)
    @rails = curricula(:one)
  end

  test "should show profile info" do
    assert_equal "Firstname Lastname", @user.full_name
    assert_equal "one@email.com", @user.email
    assert_equal "Durham, NC", @user.current_location
    assert_equal nil, @user.website
    assert_equal "github", @user.github_profile
  end

  test "associations" do
    assert_equal @durham, @user.course.campus
    assert_equal @course, @user.course
    assert_equal @rails, @user.course.curriculum
  end
end
