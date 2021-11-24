require 'test_helper'

class IpiphilsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ipiphil = ipiphils(:one)
  end

  test "should get index" do
    get ipiphils_url
    assert_response :success
  end

  test "should get new" do
    get new_ipiphil_url
    assert_response :success
  end

  test "should create ipiphil" do
    assert_difference('Ipiphil.count') do
      post ipiphils_url, params: { ipiphil: {  } }
    end

    assert_redirected_to ipiphil_url(Ipiphil.last)
  end

  test "should show ipiphil" do
    get ipiphil_url(@ipiphil)
    assert_response :success
  end

  test "should get edit" do
    get edit_ipiphil_url(@ipiphil)
    assert_response :success
  end

  test "should update ipiphil" do
    patch ipiphil_url(@ipiphil), params: { ipiphil: {  } }
    assert_redirected_to ipiphil_url(@ipiphil)
  end

  test "should destroy ipiphil" do
    assert_difference('Ipiphil.count', -1) do
      delete ipiphil_url(@ipiphil)
    end

    assert_redirected_to ipiphils_url
  end
end
