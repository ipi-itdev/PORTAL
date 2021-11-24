require 'test_helper'

class TexxtsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @texxt = texxts(:one)
  end

  test "should get index" do
    get texxts_url
    assert_response :success
  end

  test "should get new" do
    get new_texxt_url
    assert_response :success
  end

  test "should create texxt" do
    assert_difference('Texxt.count') do
      post texxts_url, params: { texxt: {  } }
    end

    assert_redirected_to texxt_url(Texxt.last)
  end

  test "should show texxt" do
    get texxt_url(@texxt)
    assert_response :success
  end

  test "should get edit" do
    get edit_texxt_url(@texxt)
    assert_response :success
  end

  test "should update texxt" do
    patch texxt_url(@texxt), params: { texxt: {  } }
    assert_redirected_to texxt_url(@texxt)
  end

  test "should destroy texxt" do
    assert_difference('Texxt.count', -1) do
      delete texxt_url(@texxt)
    end

    assert_redirected_to texxts_url
  end
end
