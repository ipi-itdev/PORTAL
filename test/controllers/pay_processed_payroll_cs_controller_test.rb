require 'test_helper'

class PayProcessedPayrollCsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pay_processed_payroll_c = pay_processed_payroll_cs(:one)
  end

  test "should get index" do
    get pay_processed_payroll_cs_url
    assert_response :success
  end

  test "should get new" do
    get new_pay_processed_payroll_c_url
    assert_response :success
  end

  test "should create pay_processed_payroll_c" do
    assert_difference('PayProcessedPayrollC.count') do
      post pay_processed_payroll_cs_url, params: { pay_processed_payroll_c: {  } }
    end

    assert_redirected_to pay_processed_payroll_c_url(PayProcessedPayrollC.last)
  end

  test "should show pay_processed_payroll_c" do
    get pay_processed_payroll_c_url(@pay_processed_payroll_c)
    assert_response :success
  end

  test "should get edit" do
    get edit_pay_processed_payroll_c_url(@pay_processed_payroll_c)
    assert_response :success
  end

  test "should update pay_processed_payroll_c" do
    patch pay_processed_payroll_c_url(@pay_processed_payroll_c), params: { pay_processed_payroll_c: {  } }
    assert_redirected_to pay_processed_payroll_c_url(@pay_processed_payroll_c)
  end

  test "should destroy pay_processed_payroll_c" do
    assert_difference('PayProcessedPayrollC.count', -1) do
      delete pay_processed_payroll_c_url(@pay_processed_payroll_c)
    end

    assert_redirected_to pay_processed_payroll_cs_url
  end
end
