require 'test_helper'

class CoursesControllerTest < ActionController::TestCase
  setup do
    sign_in users(:one)
    @course = courses(:one)
    @course2 = courses(:two)
    @user = users(:one)
    @user2 = users(:two)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:courses)
  end

  test "should not get index if not a campus director" do
    sign_out @user
    sign_in @user2
    get :index
    assert_redirected_to root_path
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create course" do
    assert_difference('Course.count') do
      post :create, course: { campus_id: @course.campus_id, curriculum_id: @course.curriculum_id,
          ended_on: @course.ended_on, started_on: (Date.today + 1.day) }
    end

    assert_redirected_to courses_path
  end

  test "should show course" do
    get :show, id: @course
    assert_response :success
  end

  test "should not show course at other campus" do
    get :show, id: @course2
    assert_redirected_to root_path
  end

  test "should get edit" do
    get :edit, id: @course
    assert_response :success
  end

  test "should not get edit for course at other campus" do
    get :edit, id: @course2
    assert_redirected_to root_path
  end

  test "should get add_students" do
    get :add_students, id: @course
    assert_response :success
  end

  test "should update course" do
    patch :update, id: @course, course: { campus_id: @course.campus_id,
        curriculum_id: @course.curriculum_id, ended_on: @course.ended_on, started_on: (Date.today + 1.day),
        :users_attributes=>{"0" => {id: @user.id, first_name: @user.first_name, last_name: @user.last_name,
          email: @user.email, password: "password"}}}

    assert_redirected_to courses_path
  end

  test "should destroy course" do
    assert_difference('Course.count', -1) do
      delete :destroy, id: @course
    end

    assert_redirected_to courses_path
  end
end
