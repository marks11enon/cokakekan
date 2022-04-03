require "test_helper"

class DetailsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get details_new_url
    assert_response :success
  end

  test "should get index" do
    get details_index_url
    assert_response :success
  end

  test "should get show" do
    get details_show_url
    assert_response :success
  end
end
