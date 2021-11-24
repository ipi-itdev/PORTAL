require 'test_helper'

class PayslipsettingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @payslipsetting = payslipsettings(:one)
  end

  test "should get index" do
    get payslipsettings_url
    assert_response :success
  end

  test "should get new" do
    get new_payslipsetting_url
    assert_response :success
  end

  test "should create payslipsetting" do
    assert_difference('Payslipsetting.count') do
      post payslipsettings_url, params: { payslipsetting: { description: @payslipsetting.description, note: @payslipsetting.note, path: @payslipsetting.path, show: @payslipsetting.show, value: @payslipsetting.value } }
    end

    assert_redirected_to payslipsetting_url(Payslipsetting.last)
  end

  test "should show payslipsetting" do
    get payslipsetting_url(@payslipsetting)
    assert_response :success
  end

  test "should get edit" do
    get edit_payslipsetting_url(@payslipsetting)
    assert_response :success
  end

  test "should update payslipsetting" do
    patch payslipsetting_url(@payslipsetting), params: { payslipsetting: { description: @payslipsetting.description, note: @payslipsetting.note, path: @payslipsetting.path, show: @payslipsetting.show, value: @payslipsetting.value } }
    assert_redirected_to payslipsetting_url(@payslipsetting)
  end

  test "should destroy payslipsetting" do
    assert_difference('Payslipsetting.count', -1) do
      delete payslipsetting_url(@payslipsetting)
    end

    assert_redirected_to payslipsettings_url
  end
end
