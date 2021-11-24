require 'test_helper'

class PayProcessedPayrollUsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pay_processed_payroll_u = pay_processed_payroll_us(:one)
  end

  test "should get index" do
    get pay_processed_payroll_us_url
    assert_response :success
  end

  test "should get new" do
    get new_pay_processed_payroll_u_url
    assert_response :success
  end

  test "should create pay_processed_payroll_u" do
    assert_difference('PayProcessedPayrollU.count') do
      post pay_processed_payroll_us_url, params: { pay_processed_payroll_u: {  } }
    end

    assert_redirected_to pay_processed_payroll_u_url(PayProcessedPayrollU.last)
  end

  test "should show pay_processed_payroll_u" do
    get pay_processed_payroll_u_url(@pay_processed_payroll_u)
    assert_response :success
  end

  test "should get edit" do
    get edit_pay_processed_payroll_u_url(@pay_processed_payroll_u)
    assert_response :success
  end

  test "should update pay_processed_payroll_u" do
    patch pay_processed_payroll_u_url(@pay_processed_payroll_u), params: { pay_processed_payroll_u: {  } }
    assert_redirected_to pay_processed_payroll_u_url(@pay_processed_payroll_u)
  end

  test "should destroy pay_processed_payroll_u" do
    assert_difference('PayProcessedPayrollU.count', -1) do
      delete pay_processed_payroll_u_url(@pay_processed_payroll_u)
    end

    assert_redirected_to pay_processed_payroll_us_url
  end
end
