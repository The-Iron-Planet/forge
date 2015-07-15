require 'test_helper'

class PositionTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @user2 = users(:two)
    @tiy = companies(:one)
    @google = companies(:two)
    @tiy_job = positions(:one)
    @google_job = positions(:two)
  end

  test "associations" do
    assert_equal [@tiy_job], @user.positions
    assert_equal [@google_job], @user2.positions
    assert_equal [@user], @tiy.users
    assert_equal [@user2], @google.users
  end

  test "company names" do
    assert_equal "The Iron Yard: Durham, NC", @tiy_job.company_name
    assert_equal "Google: Mountain View, CA", @google_job.company_name
  end

  test "ordered scope" do
    assert_equal @google_job, Position.first
    assert_equal @tiy_job, Position.ordered.first
  end

  test "date display" do
    assert_equal "July 2015", @google_job.start_date
    assert_equal "August 2015", @tiy_job.end_date
  end

  test "current position based on start date" do
    assert_equal @tiy_job, @user.current_position
    new_job = Position.create!(user_id: @user.id, company_id: @google.id, title: "Googler",
        started_on: "2015-08-01")
    assert_equal new_job, @user.current_position
  end

  test "can't create without company, title, start date" do
    job1 = Position.new(user_id: @user.id, company_id: @google.id, title: "Googler",
        started_on: "2015-08-01")
    job2 = Position.new(user_id: @user.id, company_id: @google.id, title: "Googler")
    job3 = Position.new(user_id: @user.id, company_id: @google.id, started_on: "2015-08-01")
    job4 = Position.new(user_id: @user.id, title: "Googler", started_on: "2015-08-01")

    assert job1.save
    refute job2.save
    refute job3.save
    refute job4.save
  end
end
