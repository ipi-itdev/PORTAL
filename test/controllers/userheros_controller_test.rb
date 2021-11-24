require 'test_helper'

class UserherosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @userhero = userheros(:one)
  end

  test "should get index" do
    get userheros_url
    assert_response :success
  end

  test "should get new" do
    get new_userhero_url
    assert_response :success
  end

  test "should create userhero" do
    assert_difference('Userhero.count') do
      post userheros_url, params: { userhero: { email: @userhero.email, login: @userhero.login, name: @userhero.name } }
    end

    assert_redirected_to userhero_url(Userhero.last)
  end

  test "should show userhero" do
    get userhero_url(@userhero)
    assert_response :success
  end

  test "should get edit" do
    get edit_userhero_url(@userhero)
    assert_response :success
  end

  test "should update userhero" do
    patch userhero_url(@userhero), params: { userhero: { email: @userhero.email, login: @userhero.login, name: @userhero.name } }
    assert_redirected_to userhero_url(@userhero)
  end

  test "should destroy userhero" do
    assert_difference('Userhero.count', -1) do
      delete userhero_url(@userhero)
    end

    assert_redirected_to userheros_url
  end
end
