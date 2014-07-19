# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


CATEGORY = ['Marketing at Work', 'Marketing Stories', 'Random Stuff']
CATEGORY.each { |category| Category.create!(name: category) } if Category.count.eql? 0

if Rails.env.development?
  Article.delete_all

  10.times do |i|
    Article.create(
      title: Faker::Lorem.sentence,
      short_content: Faker::Lorem.paragraph(4),
      content: Faker::Lorem.paragraph(4),
      category_id:
        Category
        .offset(rand(Category.count))
        .first
        .id
    )
  end
end

User.create(
  email: 'admin@phuongbui.me',
  password: 'phuongbui.me'
) unless User.find_by_email('admin@phuongbui.me')

BlogSetting::DEFAULT_SETTING.each do  |key, value|
  BlogSetting.create(key: key, value: value)
end
BlogSetting.send(:restart_setting)
