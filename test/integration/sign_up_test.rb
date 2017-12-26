require 'test_helper'

class SignUpTest < ActionDispatch::IntegrationTest

  def setup
    # @user = User.create(username: "john", email: "john@mail.com", password: "password")
    @username = "john"
    @email = "john@mail.com"
    @password = "password"
    # @user1 = User.create(username: "jo", email: "john@mail.com", password: "password")
    # @user2 = User.create(username: "john", email: "john@mail.com", password: "password", admin: true)
  end

  test "get sign up form and sign up" do
    get signup_path
    assert_template 'users/new'
    assert_difference 'User.count', 1 do # verify that there is the User count increases upon User creation
      @user = User.create(username: @username, email: @email, password: @password)
    end
    # assert_template "users/#{@user.id}"
    assert_match @user.username, User.last.username # check to make sure the new user has been created and exists
  end

end