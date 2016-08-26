require 'test_helper'

class SamplesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get sub1" do
    get :sub1
    assert_response :success
  end

  test "should get sub2" do
    get :sub2
    assert_response :success
  end

end
