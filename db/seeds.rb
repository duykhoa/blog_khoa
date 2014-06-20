# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
10.times do |i|
  Article.create(
    title: Faker::Lorem.sentence,
    short_content: Faker::Lorem.paragraph(4),
    content: Faker::Lorem.paragraph(4)
  )
end

User.create(
  email: 'admin@phuongbui.me',
  password: 'phuongbui.me'
)
