FactoryBot.define do
  factory :book_request do
    status "MyString"
    note "MyText"
    user nil
    child nil
    request nil
  end
end
