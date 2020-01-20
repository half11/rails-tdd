require 'test_helper'

class PostFlowTest < ActionDispatch::IntegrationTest
  test "can see the post#index as homepage" do
    get "/"
    assert_select "h1", "Post#Index"
  end

  test "can create a post" do
    get "/posts/new"
    assert_response :success

    post "/posts",
      params: { post: {title: "Post title", body: "Post body"} }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "h2", "Post title"
    assert_select "p", "Post body"
  end

  test "can see form on post#new route" do
    get "/posts/new"
    assert_select "form" do |elements|
      elements.each do |element|
        assert_select element, "input", 3
      end
    end

  end
end
