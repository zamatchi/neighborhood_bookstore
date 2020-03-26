# (1..20).each do |i|
#   name = Faker::Book.title
#   author = Faker::Book.author
#   description = "出版: " + Faker::Book.publisher + ", ジャンル: " + Faker::Book.genre
#   price = i * 100
#   num = i
#   Product.create!(name: name, author: author, description: description, price: price, num: num)
# end

# User.create!(
#   name: "管理ユーザー",
#   email: ENV['ADMIN_EMAIL'],
#   idname: ENV['ADMIN_IDNAME'],
#   password: ENV['ADMIN_PASSWORD'],
#   password_confirmation: ENV['ADMIN_PASSWORD'],
#   admin: true
# )

puts "---開始---"

User.first.purchase_history = User.first.build_purchase_history
User.third.purchase_history = User.third.build_purchase_history

PurchaseHistoryProduct.create!(
  user_name: User.first.name,
  product_name: "To a God Unknown",
  quantity: 2,
  price: 700,
  product_id: 7,
  purchase_history_id: 1,
  delivery_user: "サンプル太郎"
)

PurchaseHistoryProduct.create!(
  user_name: User.first.name,
  product_name: "The Golden Apples of the Sun",
  quantity: 1,
  price: 2000,
  product_id: 20,
  purchase_history_id: 1,
  delivery_user: "taro"
)

PurchaseHistoryProduct.create!(
  user_name: User.third.name,
  product_name: "The Needle's Eye",
  quantity: 1,
  price: 500,
  product_id: 5,
  purchase_history_id: 2,
  delivery_user: "guest"
)


puts "---終了---"