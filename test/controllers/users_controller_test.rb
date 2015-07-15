require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    sign_in users(:one)
    @user1 = users(:one)
    @user2 = users(:two)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    # byebug
    assert_difference('User.count') do
      post :create, user: {first_name: @user2.first_name, last_name: @user2.last_name,
          email: "email@email.com", curriculum_id: @user2.curriculum.id, campus_id: @user2.campus.id,
          course_id: @user2.course.id}
    end
    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @user1
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user1
    assert_response :success
  end

  test "should update user with more than 1 login" do
    patch :update, id: @user1, user: { first_name: @user1.first_name }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should render edit when errors on update for user1" do
    patch :update, id: @user1, user: { email: "" }
    assert_response :success
    response.body.match(/you can edit your profile here/)
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user1
    end

    assert_redirected_to users_path
  end

  test "should get dashboard" do
    get :dashboard
    assert_response :success
    response.body.match(/Forge/)
  end

  test "should get first login" do
    sign_out users(:one)
    sign_in users(:two)

    get :index
    assert_redirected_to first_login_path
  end

  test "should render first_logon when errors on update for user2" do
    sign_out users(:one)
    sign_in users(:two)

    get :index
    assert_redirected_to first_login_path

    patch :update, id: @user2, user: { password: "password", password_confirmation: "junkword" }
    assert_response :success
    response.body.match(/your first time logging in/)

    patch :update, id: @user2, user: { password: "pass", password_confirmation: "pass" }
    assert_response :success
    response.body.match(/your first time logging in/)

    patch :update, id: @user2, user: { password: "password", password_confirmation: "password" }
    assert_redirected_to user_path
  end

  # test "should show user profile picture" do
  #
  # end
end
