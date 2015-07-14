require 'test_helper'

class ResourcesControllerTest < ActionController::TestCase
  setup do
    sign_in users(:one)
    @resource = resources(:one)
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:resources)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create resource" do
    assert_difference('Resource.count') do
      post :create, resource: { curriculum_id: @resource.curriculum_id,
          description: @resource.description, title: @resource.title, 
          user_id: @user.id, website: @resource.website }
    end

    assert_redirected_to resources_path
  end

  test "should get edit" do
    get :edit, id: @resource
    assert_response :success
  end

  test "should update resource" do
    patch :update, id: @resource, resource: { curriculum_id: @resource.curriculum_id, description: @resource.description, title: @resource.title, user_id: @resource.user_id, website: @resource.website }
    assert_redirected_to resources_path
  end

  test "should destroy resource" do
    assert_difference('Resource.count', -1) do
      delete :destroy, id: @resource
    end

    assert_redirected_to resources_path
  end
end
