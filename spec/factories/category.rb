FactoryGirl.define do
  factory :category do
    sequence :name do |n|
      "Category #{n}"
    end

    sequence :position do |n|
      n
    end
  end
end
