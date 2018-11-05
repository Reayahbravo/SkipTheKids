FactoryBot.define do
  factory :review do
    body "MyText"
    rating 1
    user nil
    child nil
  end
end
