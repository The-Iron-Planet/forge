require 'test_helper'

class PositionTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @user2 = users(:two)
    @tiy_job = positions(:one)
    @google_job = positions(:two)
  end

  test "associations" do
    assert_equal [@tiy_job], @user.positions
    assert_equal [@google_job], @user2.positions
  end

  test "company names" do
    assert_equal "The Iron Yard", @tiy_job.company_name
    assert_equal "Google", @google_job.company_name
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
    new_job = Position.create!(user_id: @user.id, company_name: @google_job.company_name, title: "Googler",
        started_on: "2015-08-01", city: @google_job.city, state: @google_job.state)
    assert_equal new_job, @user.current_position
  end

  test "can't create without company, title, start date, city/state" do
    job1 = Position.new(user_id: @user.id, company_name: @google_job.company_name, title: "Googler",
        started_on: "2015-08-01", city: @google_job.city, state: @google_job.state)
    job2 = Position.new(user_id: @user.id, title: "Googler",
        started_on: "2015-08-01", city: @google_job.city, state: @google_job.state)
    job3 = Position.new(user_id: @user.id, company_name: @google_job.company_name,
        started_on: "2015-08-01", city: @google_job.city, state: @google_job.state)
    job4 = Position.new(user_id: @user.id, company_name: @google_job.company_name, title: "Googler",
        city: @google_job.city, state: @google_job.state)
    job5 = Position.new(user_id: @user.id, company_name: @google_job.company_name, title: "Googler",
        started_on: "2015-08-01", state: @google_job.state)
    job6 = Position.new(user_id: @user.id, company_name: @google_job.company_name, title: "Googler",
        started_on: "2015-08-01", city: @google_job.city)

    assert job1.save
    refute job2.save
    refute job3.save
    refute job4.save
    refute job5.save
    refute job6.save
  end
end
