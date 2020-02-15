# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


(1..10).each do |i|
  name = Faker::Book.title
  author = Faker::Book.author
  description = "出版: " + Faker::Book.publisher + "ジャンル: " + Faker::Book.genre
  price = i * 100
  num = i
  Product.create!(name: name, author: author, description: description, price: price, num: num)
end

puts "終了！！"