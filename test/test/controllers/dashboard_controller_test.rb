#/workspaces/Inventory-Management-System/test/test/controllers/dashboard_controller_test.rb
require "test_helper"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get dashboard_index_url
    assert_response :success
  end
end
