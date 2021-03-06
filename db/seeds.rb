CATEGORY = ['Marketing at Work', 'Marketing Stories', 'Random Stuff']
CATEGORY.each_with_index { |category, index| Category.create!(name: category, position: index) } if Category.count.eql? 0

if Rails.env.development?
  Article.delete_all

  10.times do |i|
    Article.create(
      title: Faker::Lorem.sentence,
      short_content: Faker::Lorem.paragraph(4),
      content: Faker::Lorem.paragraphs(4).join,
      category_id:
        Category
        .offset(rand(Category.count))
        .first
        .id
    )
  end
end

User.create(
  email: 'admin@admin.com',
  password: '1234qwer'
)

BlogSetting.destroy_all

BlogSetting::DEFAULT_SETTING.each do  |key, value|
  BlogSetting.create(key: key, value: value)
end

About.create(content: "no content")
