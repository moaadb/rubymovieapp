require "test_helper"

class UserTest < ActiveSupport::TestCase
  require "test_helper"

  setup do
    # Load in valid credit card fixture as a basis for all tests
    @user = users(:one)
  end

  test "valid: create user" do
    t_user = @user
    assert t_user.save()
  end

  test "invalid: email does not have @ symbol" do
    t_user = @user
    # No @ sign with domain
    t_user.email = "emailwhat.com"
    assert_not t_user.save()
    # No @ sign or domain
    t_user.email = "emailwhat"
    assert_not t_user.save()
  end

  test "invalid: email has no domain" do
    t_user = @user
    # No domain with @ sign
    t_user.email = "email@wha"
    assert_not t_user.save()
    # No domain or @ sign
    t_user.email = "emailwhacom"
    assert_not t_user.save()
  end

  test "invalid: user missing parameters" do
    # No email
    t_user = @user
    t_user.email = nil
    assert_not t_user.save()
    # No username
    t_user = @user
    t_user.username = nil
    assert_not t_user.save()
  end

end
