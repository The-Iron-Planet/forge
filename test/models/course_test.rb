require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  setup do
    @course1 = courses(:one)
    @course2 = courses(:two)
    @user1 = users(:one)
    @user2 = users(:two)
    @durham = campuses(:one)
    @greenville = campuses(:two)
    @rails = curricula(:one)
    @python = curricula(:two)
  end

  test "must include all fields" do
    c1=Course.new(started_on: "", ended_on: (Date.today + 1.month),
        campus_id: @durham.id, curriculum_id: @rails.id, cohort: 4)
    c2=Course.new(started_on: (Date.today - 1.month), ended_on: "",
        campus_id: @durham.id, curriculum_id: @rails.id, cohort: 4)
    c3=Course.new(started_on: (Date.today - 1.month), ended_on: (Date.today + 1.month),
        campus_id: nil, curriculum_id: @rails.id, cohort: 4)
    c4=Course.new(started_on: (Date.today - 1.month), ended_on: (Date.today + 1.month),
        campus_id: @durham.id, curriculum_id: nil, cohort: 4)
    c5=Course.new(started_on: (Date.today - 1.month), ended_on: (Date.today + 1.month),
        campus_id: @durham.id, curriculum_id: @rails.id, cohort: nil)
    c6=Course.new(started_on: (Date.today - 1.month), ended_on: (Date.today + 1.month),
        campus_id: @durham.id, curriculum_id: @rails.id, cohort: 4)

    refute c1.save
    refute c2.save
    refute c3.save
    refute c4.save
    refute c5.save
    assert c6.save
  end

  test "cohort must be unique within scope of campus and curriculum" do
    c1=Course.new(started_on: Date.today, ended_on: (Date.today + 1.day), campus_id: @course1.campus_id,
        curriculum_id: @course1.curriculum_id, cohort: @course1.cohort)
    c2=Course.new(started_on: Date.today, ended_on: (Date.today + 1.day), campus_id: @course2.campus_id,
        curriculum_id: @course1.curriculum_id, cohort: @course1.cohort)
    c3=Course.new(started_on: Date.today, ended_on: (Date.today + 1.day), campus_id: @course1.campus_id,
        curriculum_id: @course2.curriculum_id, cohort: @course1.cohort)
    c4=Course.new(started_on: Date.today, ended_on: (Date.today + 1.day), campus_id: @course1.campus_id,
        curriculum_id: @course1.curriculum_id, cohort: 4)

    refute c1.save
    assert c2.save
    assert c3.save
    assert c4.save
  end

  test "cohort number must be greater than zero" do
    c1=Course.new(started_on: Date.today, ended_on: (Date.today + 1.day), campus_id: @course1.campus_id,
        curriculum_id: @course1.curriculum_id, cohort: 0)
    c2=Course.new(started_on: Date.today, ended_on: (Date.today + 1.day), campus_id: @course2.campus_id,
        curriculum_id: @course1.curriculum_id, cohort: -1)

    refute c1.save
    refute c2.save
  end

  test "end date must be later than start date" do
    c1=Course.new(started_on: Date.today, ended_on: (Date.today - 1.day), campus_id: @course1.campus_id,
        curriculum_id: @course1.curriculum_id, cohort: 4)

    refute c1.save
  end

  test "knows campus short and long names" do
    assert_equal "Durham", @course1.campus_short
    assert_equal "Greenville, SC", @course2.campus_long
  end

  test "knows curriculum name" do
    assert_equal "Rails Engineering", @course1.curric_name
    assert_equal "Python Engineering", @course2.curric_name
  end

  test "displays dates concisely" do
    assert_equal "July 2015", @course1.start_date
    assert_equal "September 2015", @course2.end_date
  end

  test "full description" do
    assert_equal "Durham: Rails Cohort 1", @course1.full_description
    assert_equal "Greenville: Python Cohort 1", @course2.full_description
  end

  test "associated with users" do
    assert_equal [@user1], @course1.users
    assert_equal [@user2], @course2.users
  end

end
