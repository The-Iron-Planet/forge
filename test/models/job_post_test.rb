require 'test_helper'

class JobPostTest < ActiveSupport::TestCase
  setup do
    @job1 = job_posts(:one)
    @job2 = job_posts(:two)
    @job3 = job_posts(:three)
    @tiy = companies(:one)
    @google = companies(:two)
    @user1 = users(:one)
    @user2 = users(:two)
    @rails = curricula(:one)
    @python = curricula(:two)
  end

  test "associations" do
    assert_equal @tiy, @job1.company
    assert_equal @google, @job2.company
    assert_equal @user1, @job1.user
    assert_equal @user2, @job2.user
    assert_equal @rails, @job1.curriculum
    assert_equal @python, @job2.curriculum
  end

  test "validations" do
    j1 = JobPost.new(user_id: @user1.id, company_id: @google.id, curriculum_id: @rails.id,
        title: "Boss", description: "Great Job.", experience_desired: "Lots.", expires_on: Date.today + 1.month)
    j2 = JobPost.new(user_id: @user1.id, curriculum_id: @rails.id,
        title: "Boss", description: "Great Job.", experience_desired: "Lots.", expires_on: Date.today + 1.month)
    j3 = JobPost.new(user_id: @user1.id, company_id: @google.id,
        title: "Boss", description: "Great Job.", experience_desired: "Lots.", expires_on: Date.today + 1.month)
    j4 = JobPost.new(user_id: @user1.id, company_id: @google.id, curriculum_id: @rails.id,
        description: "Great Job.", experience_desired: "Lots.", expires_on: Date.today + 1.month)
    j5 = JobPost.new(user_id: @user1.id, company_id: @google.id, curriculum_id: @rails.id,
        title: "Boss", experience_desired: "Lots.", expires_on: Date.today + 1.month)
    j6 = JobPost.new(user_id: @user1.id, company_id: @google.id, curriculum_id: @rails.id,
        title: "Boss", description: "Great Job.", expires_on: Date.today + 1.month)
    j7 = JobPost.new(user_id: @user1.id, company_id: @google.id, curriculum_id: @rails.id,
        title: "Boss", description: "Great Job.", experience_desired: "Lots.")

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
    assert_equal false, @user1.hiring
    JobPost.create!(user_id: @user1.id, company_id: @google.id, curriculum_id: @rails.id,
        title: "Boss", description: "Great Job", experience_desired: "Many, many years.", expires_on: (Date.today + 1.month))
    @user1.reload
    assert_equal true, @user1.hiring
  end

  test "deleting job turns user's hiring field to false" do
    assert_equal true, @user2.hiring
    @job2.destroy!
    @user2.reload
    assert_equal false, @user2.hiring
  end

  test "deleting job doesn't change hiring field if user has other posts" do
    job_3 = JobPost.create!(user_id: @user2.id, company_id: @google.id, curriculum_id: @rails.id,
        title: "Boss", description: "Great Job", experience_desired: "Many, many years.", expires_on: (Date.today + 1.month))
    assert_equal true, @user2.hiring
    @job2.destroy!
    @user2.reload
    assert_equal true, @user2.hiring
    job_3.destroy!
    @user2.reload
    assert_equal false, @user2.hiring
  end

  test "search returns accurate results" do
    assert_equal [@job1], JobPost.search_results(@rails.id, @tiy.city, @tiy.state,
        @job1.company_id, @job1.description, @job1.experience_desired)
    assert_equal JobPost.ordered.all_active, JobPost.search_results("", "", "", "", "", "")
  end

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
