require "test_helper"

class AccountedControllerTest < ActionDispatch::IntegrationTest
  test "should get teachers" do
    get accounted_teachers_url
    assert_response :success
  end

  test "should get students" do
    get accounted_students_url
    assert_response :success
  end
end
