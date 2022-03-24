require "test_helper"

class KindsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @kind = kinds(:one)
  end

  routes = [
    {action: 'index', method: :get, url: '/kinds', params: nil},
    {action: 'new', method: :get, url: '/kinds/new', params: nil},
    {action: 'create', method: :post, url: '/kinds', params: { kind: { description: 'description', name: 'name' } }},
    {action: 'show', method: :get, url: '/kinds/1', params: nil},
    {action: 'edit', method: :get, url: '/kinds/1/edit', params: nil},
    {action: 'update', method: :patch, url: '/kinds/1', params: { kind: { description: 'description', name: 'name' } }},
    {action: 'destroy', method: :delete, url: '/kinds/1', params: nil},
  ]

  routes.each do |route|
    test "should not have #{route[:action]} route" do
      assert_raises(ActionController::RoutingError) do
        send(route[:method], route[:url], params: route[:params])
      end
    end
  end

end
