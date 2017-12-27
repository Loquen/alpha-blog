require 'test_helper'

class SignUpTest < ActionDispatch::IntegrationTest

  def setup
    @username = "john"
    @email = "john@mail.com"
    @password = "password"
    @invalidusername = "jo"
    @email1 = "john"
    @password1 = ""
  end

  test "get sign up form and sign up" do
    get signup_path
    assert_template 'users/new'
    assert_difference 'User.count', 1 do # verify that there is the User count increases upon User creation
      @user = User.create(username: @username, email: @email, password: @password)
    end
    assert_match @user.username, User.last.username # check to make sure the new user has been created and exists
  end
  
  test "invalid username results in failure" do
    get signup_path
    assert_template 'users/new'
    assert_no_difference 'User.count' do
      @user = User.create(username: @invalidusername, email: @email, password: @password)
    end
    assert_template 'users/new'
    assert_no_difference 'User.count' do
      post users_path, user: {username: "j", email: "lo@gm.cm", password: "password" }
    end
    assert_match "Username is too short", response.body
    assert_select 'h2.panel-title' # not able to find this because the signup is not actually happening through the page
    assert_select 'div.panel-body'
  end

end