require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example",
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

  test "password should not be too short" do
    @user.password = "a"*4
    assert_not @user.valid?
  end

  test "password should not be too long" do
    @user.name = "a" * 256
    assert_not @user.valid?
  end

  test "password should be accept valid password" do
    valid_passwords = %w[abcdef a10b20 10000]
    valid_passwords.each do |pass|
      @user.password = pass
      @user.password_confirmation = pass
      assert @user.valid?, "#{pass} shoud be valid"
    end
  end

  test "password shoud no be accept invalid password" do
    invalid_passwords = %w[@abcde abc-ef 10000_]
    invalid_passwords.each do |pass|
      @user.password = pass
      @user.password_confirmation = pass
      assert_not @user.valid?, "#{pass} shoud not be valid"
    end
  end

  test "name should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end
end
