FactoryGirl.define do
  factory :blog_seo do
    sequence :value do |n|
      "value#{n}"
    end
  end
end
