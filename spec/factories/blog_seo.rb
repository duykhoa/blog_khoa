FactoryGirl.define do
  factory :blog_seo do
    ignore do
      value_nil false
    end

    sequence :value do |n|
      "value#{n}"
    end

    after(:build) do |blog_seo, evalutor|
      blog_seo.value = nil if evalutor.value_nil
    end
  end
end
