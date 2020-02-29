require 'test_helper'

class PurchaseHistoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get purchase_histories_index_url
    assert_response :success
  end

end
