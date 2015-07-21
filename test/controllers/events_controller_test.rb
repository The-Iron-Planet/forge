require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  setup do
    sign_in users(:one)
    @event = events(:one)
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:events)
  end

  test "should get my events" do
    get :my_events
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create event" do
    assert_difference('Event.count') do
      post :create, event: { campus_id: @event.campus_id, description: @event.description,
          happens_on: @event.happens_on, title: @event.title, user_id: @event.user_id,
          website: @event.website, location: @event.location }
    end

    assert_redirected_to my_events_path
  end

  test "should get edit" do
    get :edit, id: @event
    assert_response :success
  end

  test "can't edit other user's events" do
    sign_out @user
    sign_in users(:two)
    get :edit, id: @event
    assert_redirected_to root_path
  end

  test "should update event" do
    patch :update, id: @event, event: { campus_id: @event.campus_id,
        description: @event.description, happens_on: @event.happens_on,
        title: @event.title, user_id: @event.user_id, website: @event.website,
        location: @event.location }
    assert_redirected_to my_events_path
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete :destroy, id: @event
    end

    assert_redirected_to root_path
  end
end
