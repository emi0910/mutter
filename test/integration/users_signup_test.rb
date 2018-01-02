require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post signup_path, params: {user:
                                   {name: "",
                                    password: "password",
                                    password_confirmation: "password"
                                   }
                                }
    end
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post signup_path, params: {user:
                                   {name: "example",
                                    password: "password",
                                    password_confirmation: "password"
                                   }
                                }
    end
  end
end
