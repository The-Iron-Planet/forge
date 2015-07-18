require 'test_helper'

class JobPostTest < ActiveSupport::TestCase
  setup do
    @job1 = job_posts(:one)
    @job2 = job_posts(:two)
    @job3 = job_posts(:three)
    @user1 = users(:one)
    @user2 = users(:two)
    @rails = curricula(:one)
    @python = curricula(:two)
  end

  test "associations" do
    assert_equal "The Iron Yard", @job1.company_name
    assert_equal "Google", @job2.company_name
    assert_equal @user1, @job1.user
    assert_equal @user2, @job2.user
    assert_equal @rails, @job1.curriculum
    assert_equal @python, @job2.curriculum
  end

  test "validations" do
    j1 = JobPost.new(user_id: @user1.id, company_name: @job2.company_name, city: @job2.city, state: @job2.state,
        curriculum_id: @rails.id, title: "Boss", experience_desired: "Lots.")
    j2 = JobPost.new(user_id: @user1.id, city: @job2.city, state: @job2.state,
        curriculum_id: @rails.id, title: "Boss", experience_desired: "Lots.")
    j3 = JobPost.new(user_id: @user1.id, company_name: @job2.company_name, state: @job2.state,
        curriculum_id: @rails.id, title: "Boss", experience_desired: "Lots.")
    j4 = JobPost.new(user_id: @user1.id, company_name: @job2.company_name, city: @job2.city,
        curriculum_id: @rails.id, title: "Boss", experience_desired: "Lots.")
    j5 = JobPost.new(user_id: @user1.id, company_name: @job2.company_name, city: @job2.city, state: @job2.state,
        title: "Boss", experience_desired: "Lots.")
    j6 = JobPost.new(user_id: @user1.id, company_name: @job2.company_name, city: @job2.city, state: @job2.state,
        curriculum_id: @rails.id,  experience_desired: "Lots.")
    j7 = JobPost.new(user_id: @user1.id, company_name: @job2.company_name, city: @job2.city, state: @job2.state,
        curriculum_id: @rails.id, title: "Boss")

    assert j1.save
    refute j2.save
    refute j3.save
    refute j4.save
    refute j5.save
    refute j6.save
    refute j7.save
  end

  test "scope ordered by last update" do
    assert_equal [@job3, @job2, @job1], JobPost.all.ordered
    @job1.description = "Updated Description!"
    @job1.save!
    assert_equal [@job1, @job3, @job2], JobPost.all.ordered
  end

  test "posting a job turns user's hiring field to true" do
    assert_equal false, @user2.hiring
    JobPost.create!(user_id: @user2.id, company_name: @job2.company_name, city: @job2.city, state: @job2.state,
        curriculum_id: @rails.id, title: "Boss", experience_desired: "Lots.")
    @user2.reload
    assert_equal true, @user2.hiring
  end

  test "deleting job turns user's hiring field to false" do
    assert_equal true, @user1.hiring
    @job1.destroy!
    @user1.reload
    assert_equal false, @user1.hiring
  end

  test "marking a job active turns user's hiring field to true" do
    assert_equal false, @user2.hiring
    @job2.active = true
    @job2.save!
    @user2.reload
    assert_equal true, @user2.hiring
  end

  test "marking a job inactive turns user's hiring field to false" do
    assert_equal true, @user1.hiring
    @job1.active = false
    @job1.save!
    @user1.reload
    assert_equal false, @user1.hiring
  end

  test "deleting job doesn't change hiring field if user has other active posts" do
    assert_equal true, @user1.hiring
    new_job = JobPost.create!(user_id: @user1.id, company_name: @job2.company_name, city: @job2.city, state: @job2.state,
        curriculum_id: @rails.id, title: "Boss", experience_desired: "Lots.", active: true, expires_on: Date.today + 1.month)
    @job1.destroy!
    @user1.reload
    assert_equal true, @user1.hiring
    new_job.destroy!
    @user1.reload
    assert_equal false, @user1.hiring
  end

  test "marking a job inactive doesn't change hiring field if user has other active posts" do
    assert_equal true, @user1.hiring
    new_job = JobPost.create!(user_id: @user1.id, company_name: @job2.company_name, city: @job2.city, state: @job2.state,
        curriculum_id: @rails.id, title: "Boss", experience_desired: "Lots.", active: true, expires_on: Date.today + 1.month)
    @job1.active = false
    @job1.save!
    @user1.reload
    assert_equal true, @user1.hiring
    new_job.active = false
    new_job.save!
    @user1.reload
    assert_equal false, @user1.hiring
  end

  test "deleting job DOES change hiring field if all of user's other posts are inactive" do
    new_job = JobPost.create!(user_id: @user1.id, company_name: @job2.company_name, city: @job2.city, state: @job2.state,
        curriculum_id: @rails.id, title: "Boss", experience_desired: "Lots.", active: false, expires_on: Date.today + 1.month)
    assert_equal true, @user1.hiring
    @job1.destroy!
    @user1.reload
    assert_equal false, @user1.hiring
  end

  # test "search returns accurate results" do
  #   assert_equal [@job1], JobPost.search_results(@rails.id, @tiy.city, @tiy.state,
  #       @job1.company_id, @job1.description, @job1.experience_desired)
  #   assert_equal JobPost.ordered.all_active, JobPost.search_results("", "", "", "", "", "")
  # end

  test "all active method - deactivate" do
    assert_equal [@job1], JobPost.all_active
    @job1.active = false
    @job1.save
    assert_equal [], JobPost.all_active
  end

  test "all active method - expires_on" do
    assert_equal [@job1], JobPost.all_active
    @job3.expires_on = Date.today + 1.month #@job3 was originally expired, but is still marked inactive
    @job3.save
    assert_equal [@job1], JobPost.all_active
    @job3.active = true
    @job3.save
    assert_equal [@job3, @job1], JobPost.all_active
  end

end
