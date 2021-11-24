require 'test_helper'

class RenewsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @renews = renews(:one)
  end

  test "should get index" do
    get renews_url
    assert_response :success
  end

  test "should get new" do
    get new_renews_url
    assert_response :success
  end

  test "should create renews" do
    assert_difference('Renew.count') do
      post renews_url, params: { renews: {  } }
    end

    assert_redirected_to renews_url(Renew.last)
  end

  test "should show renews" do
    get renews_url(@renews)
    assert_response :success
  end

  test "should get edit" do
    get edit_renews_url(@renews)
    assert_response :success
  end

  test "should update renews" do
    patch renews_url(@renews), params: { renews: {  } }
    assert_redirected_to renews_url(@renews)
  end

  test "should destroy renews" do
    assert_difference('Renew.count', -1) do
      delete renews_url(@renews)
    end

    assert_redirected_to renews_url
  end
end
