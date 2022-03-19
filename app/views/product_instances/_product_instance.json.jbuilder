json.extract! product_instance,
                :id,
                :combination_id,
                :quantity,
                :created_at,
                :updated_at
json.total_value number_to_currency(@product_instance.total_value)
json.errors @product_instance.errors
json.shopping_cart {
  json.extract! product_instance.shopping_cart,
                  :id,
                  :created_at,
                  :updated_at
  json.total_value number_to_currency(@product_instance.shopping_cart.total_value)

}
json.url set_combination_product_instance_url(product_instance, format: :json)
