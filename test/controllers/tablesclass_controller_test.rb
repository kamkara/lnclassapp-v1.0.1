require "test_helper"

class TablesclassControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tablesclass_index_url
    assert_response :success
  end
end
