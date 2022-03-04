# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
include ApplicationHelper

seeds_message("Creating users") do
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development? && AdminUser.find_by_email('admin@example.com').nil?
  User.create!(email: 'user@example.com', password: 'Teste123', password_confirmation: 'Teste123') if Rails.env.development? && User.find_by_email('user@example.com').nil?
end

seeds_message("Creating kinds") do
  kinds = [
    { name: "Piscina", description: 'Um bolo cuja cobertura fica apenas na parte de cima, contida dentro de uma "piscina" com bordas feitas de massa de bolo.' },
    { name: "Vulcão", description: 'Um bolo com um furo cheio até o topo com recheio!' },
  ]
  kinds.each do |attributes|
    next if Kind.find_by_name(attributes[:name])
    Kind.create(attributes)
  end
end

seeds_message("Creating sizes") do
  sizes = [
    { name: "Grande", description: "8 a 10 porções" },
    { name: "Pequeno", description: "4 a 6 porções" },
  ]
  sizes.each do |attributes|
    next if Size.find_by_name(attributes[:name])
    Size.create(attributes)
  end
end

seeds_message("Creating products") do
  products = [
    { name: "Bolo A",
      description: "Descrição do Bolo A", 
    },
    { name: "Bolo B",
      description: "Descrição do Bolo B", 
    }
  ]
  
  products.each do |attributes|
    next if Product.find_by_name(attributes[:name])
    Product.create(attributes)
  end
  
  combinations = [
    { product: Product.find_by_name("Bolo A"), kind: Kind.find_by_name("Piscina"), size: Size.find_by_name("Pequeno"), price: 10 },
    { product: Product.find_by_name("Bolo A"), kind: Kind.find_by_name("Vulcão"), size: Size.find_by_name("Pequeno"), price: 15 },
    { product: Product.find_by_name("Bolo B"), kind: Kind.find_by_name("Piscina"), size: Size.find_by_name("Grande"), price: 20 },
    { product: Product.find_by_name("Bolo B"), kind: Kind.find_by_name("Vulcão"), size: Size.find_by_name("Grande"), price: 30 },
  ]
  
  combinations.each do |attributes|
    next if Combination.where(attributes).count > 0
    Combination.create(attributes)
  end

  Dir.glob('db/default_data/assets/product_photos/*.*').each do |filename|
    attachment_name = filename.split(/\//).last.split(/\./).first
    File.open(filename, 'rb') do |file|
      product = Product.find_by_name(attachment_name)
      product.photo = ActiveStorage::Blob.create_and_upload!(io: file, content_type: 'image/jpeg', filename: attachment_name)
      product.save!      
    end
  end

end
