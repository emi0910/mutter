require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:example)
    @other = users(:other)
  end

  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "should destoroy when logged in as admin" do
    log_in_as(@user)
    assert_difference 'User.count', -1 do
      delete user_path(@user)
    end
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end
end
