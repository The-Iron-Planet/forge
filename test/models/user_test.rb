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
    @user3 = users(:three)
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

  test "can create campus director without course and curriculum" do
    cd = User.new(first_name: @user1.first_name, last_name: @user1.last_name,
        email: "cd@email.com", campus_id: @durham.id, is_cd: true, password: "password")
    assert cd.save
  end

  test "can create instructor without course but must have curriculum" do
    good_instructor = User.new(first_name: @user1.first_name, last_name: @user1.last_name,
        email: "instructor1@email.com", is_instructor: true, campus_id: @durham.id,
        curriculum_id: @rails.id, password: "password")
    bad_instructor = User.new(first_name: @user1.first_name, last_name: @user1.last_name,
        email: "instructor2@email.com", is_instructor: true, campus_id: @durham.id,
        curriculum_id: nil, password: "password")

    assert good_instructor.save
    refute bad_instructor.save
  end

  test "different users display different Iron Yard relationships" do
    assert_equal "Durham: Staff", @user1.tiy_relation #campus director
    assert_equal "Greenville: Python - July 2015", @user2.tiy_relation #student
    assert_equal "Greenville: Rails - Instructor", @user3.tiy_relation #instructor
  end

  test "email event filter selects correct users" do
    assert_equal [@user1], User.event_email_filter(@durham.id)
    assert_equal [@user2], User.event_email_filter(@greenville.id)
    @user3.get_event_email = true
    @user3.save!
    assert_equal [@user3, @user2], User.event_email_filter(@greenville.id)
    @user3.campus_notification_id = @durham.id
    @user3.save!
    assert_equal [@user3, @user1], User.event_email_filter(@durham.id)
    assert_equal [@user2], User.event_email_filter(@greenville.id)
  end
end
