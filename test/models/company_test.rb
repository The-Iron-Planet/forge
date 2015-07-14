require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @user2 = users(:two)
    @tiy = companies(:one)
    @google = companies(:two)
    @tiy_job = positions(:one)
    @google_job = positions(:two)
  end

  test "knows users & positions" do
    assert_equal [@user], @tiy.users
    assert_equal [@user2], @google.users
    assert_equal [@tiy_job], @tiy.positions
    assert_equal [@google_job], @google.positions
  end

  test "name options" do
    assert_equal "Google: Mountain View, CA", @google.name_and_location
    assert_equal "Durham, NC", @tiy.location
  end

  test "ordered by name, then state/city" do
    assert_equal [@google, @tiy], Company.all
    red_hat = Company.create!(name: "Red Hat", city: "Raleigh", state: "NC")
    google_2 = Company.create!(name: "Google", city: "Raleigh", state: "NC")
    assert_equal [@google, @tiy, red_hat, google_2], Company.all
    assert_equal [@google, google_2, red_hat, @tiy], Company.all.ordered
  end

  test "validates name, city, state" do
    c1 = Company.new(name: "Citrix", city: "Raleigh", state: "NC")
    c2 = Company.new(city: "Raleigh", state: "NC")
    c3 = Company.new(name: "Citrix", state: "NC")
    c4 = Company.new(name: "Citrix", city: "Raleigh")

    assert c1.save
    refute c2.save
    refute c3.save
    refute c4.save
  end

  test "name unique within city/state" do
    c1 = Company.new(name: @google.name, city: @google.city, state: @google.state)
    c2 = Company.new(name: @google.name, city: "Los Angeles", state: @google.state)
    c3 = Company.new(name: @google.name, city: @google.city, state: "NC")
    c4 = Company.new(name: "Apple", city: @google.city, state: @google.state)

    refute c1.save
    assert c2.save
    assert c3.save
    assert c4.save
  end

end
