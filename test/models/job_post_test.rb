require 'test_helper'

class JobPostTest < ActiveSupport::TestCase
  setup do
    @job1 = job_posts(:one)
    @job2 = job_posts(:two)
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
        title: "Boss", description: "Great Job.", experience_desired: "Lots.")
    j2 = JobPost.new(user_id: @user1.id, curriculum_id: @rails.id,
        title: "Boss", description: "Great Job.", experience_desired: "Lots.")
    j3 = JobPost.new(user_id: @user1.id, company_id: @google.id,
        title: "Boss", description: "Great Job.", experience_desired: "Lots.")
    j4 = JobPost.new(user_id: @user1.id, company_id: @google.id, curriculum_id: @rails.id,
        description: "Great Job.", experience_desired: "Lots.")
    j5 = JobPost.new(user_id: @user1.id, company_id: @google.id, curriculum_id: @rails.id,
        title: "Boss", experience_desired: "Lots.")
    j6 = JobPost.new(user_id: @user1.id, company_id: @google.id, curriculum_id: @rails.id,
        title: "Boss", description: "Great Job.")

    assert j1.save
    refute j2.save
    refute j3.save
    refute j4.save
    refute j5.save
    refute j6.save
  end
end
