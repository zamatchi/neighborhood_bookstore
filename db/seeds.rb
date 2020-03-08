# (1..20).each do |i|
#   name = Faker::Book.title
#   author = Faker::Book.author
#   description = "出版: " + Faker::Book.publisher + ", ジャンル: " + Faker::Book.genre
#   price = i * 100
#   num = i
#   Product.create!(name: name, author: author, description: description, price: price, num: num)
# end

User.create!(
  name: "管理ユーザー",
  email: ENV['ADMIN_EMAIL'],
  idname: ENV['ADMIN_IDNAME'],
  password: ENV['ADMIN_PASSWORD'],
  password_confirmation: ENV['ADMIN_PASSWORD'],
  admin: true
)

puts "---終了---"