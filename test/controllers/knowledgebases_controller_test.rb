require 'test_helper'

class KnowledgebasesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @knowledgebasis = knowledgebases(:one)
  end

  test "should get index" do
    get knowledgebases_url
    assert_response :success
  end

  test "should get new" do
    get new_knowledgebasis_url
    assert_response :success
  end

  test "should create knowledgebasis" do
    assert_difference('Knowledgebase.count') do
      post knowledgebases_url, params: { knowledgebasis: {  } }
    end

    assert_redirected_to knowledgebasis_url(Knowledgebase.last)
  end

  test "should show knowledgebasis" do
    get knowledgebasis_url(@knowledgebasis)
    assert_response :success
  end

  test "should get edit" do
    get edit_knowledgebasis_url(@knowledgebasis)
    assert_response :success
  end

  test "should update knowledgebasis" do
    patch knowledgebasis_url(@knowledgebasis), params: { knowledgebasis: {  } }
    assert_redirected_to knowledgebasis_url(@knowledgebasis)
  end

  test "should destroy knowledgebasis" do
    assert_difference('Knowledgebase.count', -1) do
      delete knowledgebasis_url(@knowledgebasis)
    end

    assert_redirected_to knowledgebases_url
  end
end
