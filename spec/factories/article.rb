FactoryGirl.define do
  factory :article do
    sequence :title do |n|
      "Article #{n}"
    end
    association :category
  end
end
