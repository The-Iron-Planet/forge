require 'test_helper'

class CoursesControllerTest < ActionController::TestCase
  setup do
    sign_in users(:one)
    @course = courses(:one)
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:courses)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create course" do
    assert_difference('Course.count') do
      post :create, course: { campus_id: @course.campus_id, cohort: 2, curriculum_id: @course.curriculum_id, ended_on: @course.ended_on, started_on: @course.started_on }
    end

    assert_redirected_to course_path(assigns(:course))
  end

  test "should show course" do
    get :show, id: @course
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @course
    assert_response :success
  end

  test "should update course" do
    patch :update, id: @course, course: { campus_id: @course.campus_id, cohort: @course.cohort,
        curriculum_id: @course.curriculum_id, ended_on: @course.ended_on, started_on: @course.started_on,
        :users_attributes=>{"0" => {id: @user.id, first_name: @user.first_name, last_name: @user.last_name,
          email: @user.email, password: "password"}}}

    assert_redirected_to course_path(assigns(:course))
  end

  test "should destroy course" do
    assert_difference('Course.count', -1) do
      delete :destroy, id: @course
    end

    assert_redirected_to courses_path
  end
end
