require 'test_helper'

class CreateArticlesTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.create(username: "john", email: "john@mail.com", password: "password")
  end

  test "get new article form and create article" do
    sign_in_as(@user,"password")
    get new_article_path
    assert_template 'articles/new'
    assert_difference 'Article.count', 1 do
      post articles_path, article: {title: "play", description: "we love to play sports"}
    end
    assert_redirected_to "/articles/#{Article.last.id}"
  end
  
  test "invalid article submission results in failure" do 
    sign_in_as(@user,"password")
    get new_article_path
    assert_template 'articles/new'
    assert_no_difference 'Article.count' do
      post articles_path, article: {title: "", description: "blah blah test test"}
    end
    assert_template 'articles/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

end
