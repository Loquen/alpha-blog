require 'test_helper'

class SignUpTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(username: "jo", email: "john@mail.com", password: "password")
    @user1 = User.create(username: "john", email: "john@mail.com", password: "password", admin: true)
    @user2 = User.create(username: "john", email: "john@mail.com", password: "password", admin: true)
  end

  test "get new category form and create category" do
    sign_in_as(@user,"password")
    get new_category_path
    assert_template 'categories/new'
    assert_difference 'Category.count', 1 do
      post_via_redirect categories_path, category: {name: "sports"}
    end
    assert_template 'categories/index'
    assert_match "sports", response.body
  end

end