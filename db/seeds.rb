# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
21.times do |n|
  title = Faker::Color.color_name
  content = Faker::Color.color_name
  email = Faker::Internet.email
  password = "password"
  Post.create!(title: title,
               content: content,
               # created_at: Wed, 17 Apr 2019 04:48:17 UTC +00:00,
               # updated_at: Wed, 17 Apr 2019 04:48:17 UTC +00:00,
               user_id: 4
               )
end
