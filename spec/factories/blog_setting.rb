FactoryGirl.define do
  factory :blog_setting do
    sequence :key do |n|
      "key#{n}"
    end

    sequence :value do |n|
      "value#{n}"
    end
  end
end
