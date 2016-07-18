FactoryGirl.define do
  factory :user do
    name 'test subject'
    email 'test@test.com'
    encrypted_password 'password'
  end
end
