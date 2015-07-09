require 'test_helper'

class CampusTest < ActiveSupport::TestCase
  setup do
    @durham = campuses(:one)
    @greenville = campuses(:two)
    @course1 = courses(:one)
    @course2 = courses(:two)
    @user1 = users(:one)
    @user2 = users(:two)
  end

  test "validates presence of both city and state" do
    c1 = Campus.new(state: "NC")
    c2 = Campus.new(city: "Raleigh")
    c3 = Campus.new(city: "Raleigh", state: "NC")

    refute c1.save
    refute c2.save
    assert c3.save
  end

  test "validates uniqueness of city within state scope" do
    c1 = Campus.new(city: "Durham", state: "NC") #same as campuses(:one)
    c2 = Campus.new(city: "Durham", state: "NH")
    c3 = Campus.new(city: "Chapel Hill", state: "NC")

    refute c1.save
    assert c2.save
    assert c3.save
  end

  test "short and long names" do
    assert_equal "Durham, NC", @durham.long_name
    assert_equal "Durham", @durham.short_name
    assert_equal "Greenville, SC", @greenville.long_name
    assert_equal "Greenville", @greenville.short_name
  end

  test "associated with courses and users" do
    assert_equal [@course1], @durham.courses
    assert_equal [@course2], @greenville.courses
    assert_equal [@user1], @durham.users
    assert_equal [@user2], @greenville.users
  end
end
