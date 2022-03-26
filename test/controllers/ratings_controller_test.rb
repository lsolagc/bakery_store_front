require "test_helper"

class RatingsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  routes = [
    {action: 'index', method: :get, url: '/ratings', params: nil},
    {action: 'new', method: :get, url: '/ratings/new', params: nil},
    {action: 'show', method: :get, url: '/ratings/1', params: nil},
    {action: 'edit', method: :get, url: '/ratings/1/edit', params: nil},
    {action: 'update', method: :patch, url: '/ratings/1', params: { rating: { score: 5, comment: 'update route' } }},
    {action: 'destroy', method: :delete, url: '/ratings/1', params: nil},
  ]

  routes.each do |route|
    test "should not have #{route[:action]} route" do
      assert_raises(ActionController::RoutingError) do
        send(route[:method], route[:url], params: route[:params])
      end
    end
  end

  test "should create rating for product" do
    user = users(:one)
    sign_in user

    product = products(:one)

    post product_ratings_path(product), params: { rating: {score: 5, comment: 'should create rating for product'} }, xhr: true
    assert_response :success
  end

  test "should respond with unauthorized if user is not logged in" do
    product = products(:one)

    post product_ratings_path(product), params: { rating: {score: 5, comment: 'should create rating for product'} }, xhr: true
    assert_response :unauthorized
  end

  test "should not create rating without product" do
    user = users(:one)
    sign_in user

    assert_raises(ActionController::UrlGenerationError) do
      post product_ratings_path(nil), params: { rating: {score: 5, comment: 'should create rating for product'} }, xhr: true
    end
  end
end
