FactoryGirl.define do
  factory :email_subscribe do
    email Faker::Internet.email
  end
end
