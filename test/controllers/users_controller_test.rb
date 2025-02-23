require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  def sign_in(user)
    post user_session_path \
      @user.username => user.username,
      @user.password => user.password
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference("User.count") do
      post users_url, params:
      {
        user:
        {
          username: "yar",
          name: "gar",
          phone_number: "1231231234",
          address: "Agh",
          email: "testing@tester.com",
          password: "secret",
          password_confirmation: "secret"
        }
      }
      puts response.body
    end

    assert_redirected_to user_url(User.last)
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params:
    {
      user:
      {
        username: @user.username,
        name: @user.name,
        phone_number: "1231231234",
        address: "Agh",
        email: @user.email,
        password: "secret",
        password_confirmation: "secret"
      }
    }
    assert_redirected_to user_url(@user)
  end

  test "should destroy user" do
    assert_difference("User.count", -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end
