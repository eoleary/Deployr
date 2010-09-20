require 'test_helper'

class PushesControllerTest < ActionController::TestCase
  test "should get commit" do
    get :commit
    assert_response :success
  end

end
