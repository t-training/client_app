require 'test_helper'

class MicropostIframesControllerTest < ActionDispatch::IntegrationTest
  test "should get show_microposts" do
    get micropost_iframes_show_microposts_url
    assert_response :success
  end

end
