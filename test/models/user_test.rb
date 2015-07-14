require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user1 = users(:one)
    @course1 = courses(:one)
    @durham = campuses(:one)
    @rails = curricula(:one)
    @tiy = companies(:one)
    @user2 = users(:two)
    @course2 = courses(:two)
    @greenville = campuses(:two)
    @python = curricula(:two)
    @google = companies(:two)
    @post1 = job_posts(:one)
    @post2 = job_posts(:two)
  end

  test "should show profile info" do
    assert_equal "Firstname Lastname", @user1.full_name
    assert_equal "one@email.com", @user1.email
    assert_equal "Durham, NC", @user1.current_location
    assert_equal nil, @user1.website
    assert_equal "github", @user1.github_profile
  end

  test "associations" do
    assert_equal @durham, @user1.course.campus
    assert_equal @course1, @user1.course
    assert_equal @rails, @user1.course.curriculum
    assert_equal [@post1], @user1.job_posts
  end

  test "search with all params but cohort/class" do
    search_1 = User.search_results(@user1.first_name, @user1.current_city, @user1.current_state,
      @rails.id, @durham.id, @user1.looking, @tiy.id, "", @user1)
    search_2 = User.search_results(@user2.last_name, @user2.current_city, @user2.current_state,
      @python.id, @greenville.id, @user2.hiring, @google.id, "", @user2)
    search_3 = User.search_results("", "", "", "", "", "", "", "", "")

    assert_equal [@user1], search_1
    assert_equal [@user2], search_2
    assert_equal User, search_3
  end

  test "search only by name" do
    search_1 = User.search_results("firstname lastname", "", "", "", "", "", "", "", "")
    search_2 = User.search_results("Doe", "", "", "", "", "", "", "", "")

    assert_equal [@user1], search_1
    assert_equal [@user2], search_2
  end
end
