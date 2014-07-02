FactoryGirl.define do
  factory :user do
    email 'admin@blog.tcom'
    password '1234qwer'
    password_confirmation '1234qwer'
  end
end
