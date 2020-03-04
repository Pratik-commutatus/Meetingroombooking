require 'test_helper'

class MeetingroomsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @meetingroom = meetingrooms(:one)
  end

  test "should get index" do
    get meetingrooms_url
    assert_response :success
  end

  test "should get new" do
    get new_meetingroom_url
    assert_response :success
  end

  test "should create meetingroom" do
    assert_difference('Meetingroom.count') do
      post meetingrooms_url, params: { meetingroom: { capacity: @meetingroom.capacity, roomname: @meetingroom.roomname } }
    end

    assert_redirected_to meetingroom_url(Meetingroom.last)
  end

  test "should show meetingroom" do
    get meetingroom_url(@meetingroom)
    assert_response :success
  end

  test "should get edit" do
    get edit_meetingroom_url(@meetingroom)
    assert_response :success
  end

  test "should update meetingroom" do
    patch meetingroom_url(@meetingroom), params: { meetingroom: { capacity: @meetingroom.capacity, roomname: @meetingroom.roomname } }
    assert_redirected_to meetingroom_url(@meetingroom)
  end

  test "should destroy meetingroom" do
    assert_difference('Meetingroom.count', -1) do
      delete meetingroom_url(@meetingroom)
    end

    assert_redirected_to meetingrooms_url
  end
end
