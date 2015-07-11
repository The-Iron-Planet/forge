require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  setup do
    sign_in users(:one)
    @event = events(:one)
    @campus = campuses(:one)
    @user = users(:one)
    @event.campus_id = @campus.id
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create event" do
    assert_difference('Event.count') do
      post :create, event: { campus_id: @campus.id, description: @event.description,
          happens_on: @event.happens_on, name: @event.name, user_id: @event.user_id,
          website: @event.website }
    end

    assert_redirected_to root_path
  end

  test "should show event" do
    get :show, id: @event
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @event
    assert_response :success
  end

  test "should update event" do
    patch :update, id: @event, event: { campus_id: @event.campus_id,
        description: @event.description, happens_on: @event.happens_on,
        name: @event.name, user_id: @event.user_id, website: @event.website }
    assert_redirected_to root_path
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete :destroy, id: @event
    end

    assert_redirected_to events_path
  end
end
