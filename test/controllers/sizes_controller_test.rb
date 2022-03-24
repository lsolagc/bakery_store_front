require "test_helper"

class SizesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @size = sizes(:one)
  end

  routes = [
    {action: 'index', method: :get, url: '/sizes', params: nil},
    {action: 'new', method: :get, url: '/sizes/new', params: nil},
    {action: 'create', method: :post, url: '/sizes', params: { size: { description: 'description', name: 'name' } }},
    {action: 'show', method: :get, url: '/sizes/1', params: nil},
    {action: 'edit', method: :get, url: '/sizes/1/edit', params: nil},
    {action: 'update', method: :patch, url: '/sizes/1', params: { size: { description: 'description', name: 'name' } }},
    {action: 'destroy', method: :delete, url: '/sizes/1', params: nil},
  ]

  routes.each do |route|
    test "should not have #{route[:action]} route" do
      assert_raises(ActionController::RoutingError) do
        send(route[:method], route[:url], params: route[:params])
      end
    end
  end

end
