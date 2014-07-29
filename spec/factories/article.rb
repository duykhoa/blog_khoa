FactoryGirl.define do
  factory :article do
    sequence :title do |n|
      "Article #{n}"
    end
    sequence :short_content do |n|
      "Short Content #{n}"
    end
    sequence :content do |n|
      "Content #{n}"
    end
    association :category
  end
end
