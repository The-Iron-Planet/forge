require 'test_helper'

class CurriculaControllerTest < ActionController::TestCase
  setup do
    sign_in users(:one)
    @curriculum = curricula(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:curricula)
  end

  test "should not get index if not a campus director" do
    sign_out users(:one)
    sign_in users(:two)
    get :index
    assert_redirected_to root_path
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create curriculum" do
    assert_difference('Curriculum.count') do
      post :create, curriculum: { name: "Front End Engineering", nickname: "Front End"}
    end

    assert_redirected_to curricula_path
  end

  test "should show curriculum" do
    get :show, id: @curriculum
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @curriculum
    assert_response :success
  end

  test "should not get edit if not a campus director" do
    sign_out users(:one)
    sign_in users(:two)
    get :edit, id: @curriculum
    assert_redirected_to root_path
  end

  test "should update curriculum" do
    patch :update, id: @curriculum, curriculum: { name: @curriculum.name }
    assert_redirected_to curriculum_path(assigns(:curriculum))
  end

  test "should destroy curriculum" do
    assert_difference('Curriculum.count', -1) do
      delete :destroy, id: @curriculum
    end

    assert_redirected_to curricula_path
  end
end
