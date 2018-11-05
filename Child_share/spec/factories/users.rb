FactoryBot.define do
  factory :user do
    first_name "MyString"
    last_name "MyString"
    email "MyString"
    password_digest "MyString"
    admin false
    parent false
  end
end
