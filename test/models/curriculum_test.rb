require 'test_helper'

class CurriculumTest < ActiveSupport::TestCase
  setup do
    @rails = curricula(:one)
    @python = curricula(:two)
    @course1 = courses(:one)
    @course2 = courses(:two)
    @user1 = users(:one)
    @user2 = users(:two)
    @post1 = job_posts(:one)
    @post2 = job_posts(:two)
  end

  test "can't create duplicates or blanks" do
    c1 = Curriculum.new(name: "", nickname: "")
    c2 = Curriculum.new(name: "Rails Engineering", nickname: "Rails")
    c3 = Curriculum.new(name: "Mobile Engineering", nickname: "")
    c4 = Curriculum.new(name: "", nickname: "Mobile")
    c5 = Curriculum.new(name: "Mobile Engineering", nickname: "Mobile")

    refute c1.save
    refute c2.save
    refute c3.save
    refute c4.save
    assert c5.save
  end

  test "nicknames" do
    assert_equal "Rails Engineering", @rails.name
    assert_equal "Rails", @rails.nickname
    assert_equal "Python Engineering", @python.name
    assert_equal "Python", @python.nickname
  end

  test "associates with courses, posts and users" do
    assert_equal [@course1], @rails.courses
    assert_equal [@course2], @python.courses
    assert_equal [@user1], @rails.users
    assert_equal [@user2], @python.users
    assert_equal [@post1], @rails.job_posts
    assert_equal [@post2], @python.job_posts
  end
end
