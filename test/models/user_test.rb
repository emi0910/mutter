require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "example",
                     password: "password",
                     password_confirmation: "password")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "  "
    assert_not @user.valid?
  end

  test "password should be present" do
    @user.password = "  "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "name should be accept valid string" do
    valid_names = %w[alice bob1024 carol-dave_eve]
    valid_names.each do |name|
      @user.name = name
      assert @user.valid?, "#{name} shoud be valid"
    end
  end

  test "name shoud no be accept invalid string" do
    invalid_names = %w[@abcde -abcef 10;000]
    invalid_names.each do |name|
      @user.name = name
      assert_not @user.valid?, "#{name} shoud not be valid"
    end
  end

  test "name should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password should not be too short" do
    @user.password = "a"*4
    assert_not @user.valid?
  end

  test "password should not be too long" do
    @user.name = "a" * 256
    assert_not @user.valid?
  end
end
