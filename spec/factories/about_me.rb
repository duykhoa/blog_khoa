FactoryGirl.define do
  factory :about_me do
    content Faker::Lorem.paragraph(5)
  end
end
