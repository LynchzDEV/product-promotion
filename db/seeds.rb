Product.destroy_all

products = [
  { name: "MacBook Pro M3", price: 2499 },
  { name: "iPhone 15 Pro", price: 999 },
  { name: "AirPods Pro", price: 249 },
  { name: "iPad Air", price: 599 },
  { name: "Apple Watch Ultra", price: 799 },
  { name: "Mac Mini", price: 699 },
  { name: "Magic Keyboard", price: 199 },
  { name: "Apple TV 4K", price: 149 }
]

products.each do |product_data|
  Product.create!(
    name: product_data[:name],
    price: product_data[:price]
  )
end
