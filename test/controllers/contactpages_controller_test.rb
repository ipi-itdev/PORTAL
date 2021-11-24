require 'test_helper'

class ContactpagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @contactpage = contactpages(:one)
  end

  test "should get index" do
    get contactpages_url
    assert_response :success
  end

  test "should get new" do
    get new_contactpage_url
    assert_response :success
  end

  test "should create contactpage" do
    assert_difference('Contactpage.count') do
      post contactpages_url, params: { contactpage: { email: @contactpage.email, message: @contactpage.message, name: @contactpage.name, subject: @contactpage.subject } }
    end

    assert_redirected_to contactpage_url(Contactpage.last)
  end

  test "should show contactpage" do
    get contactpage_url(@contactpage)
    assert_response :success
  end

  test "should get edit" do
    get edit_contactpage_url(@contactpage)
    assert_response :success
  end

  test "should update contactpage" do
    patch contactpage_url(@contactpage), params: { contactpage: { email: @contactpage.email, message: @contactpage.message, name: @contactpage.name, subject: @contactpage.subject } }
    assert_redirected_to contactpage_url(@contactpage)
  end

  test "should destroy contactpage" do
    assert_difference('Contactpage.count', -1) do
      delete contactpage_url(@contactpage)
    end

    assert_redirected_to contactpages_url
  end
end
