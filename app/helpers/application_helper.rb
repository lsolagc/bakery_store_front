module ApplicationHelper

  def seeds_message(message, &block)
    puts message
    yield
    puts "...Done!"
  end

  def pix_payments_enabled?
    ENV['PIX_PAYMENTS_ENABLED']
  end

  def pix_payments_api_request(shopping_cart)
    description = "BSFPaymentOrder#{shopping_cart.id}"
    "https://gerarqrcodepix.com.br/api/v1?nome=#{ENV['PIX_PAYMENTS_NAME']}&cidade=#{ENV['PIX_PAYMENTS_CITY']}&txid=#{description}&saida=qr&chave=#{ENV['PIX_PAYMENTS_KEY']}&valor=#{shopping_cart.total_value}"
  end
end
