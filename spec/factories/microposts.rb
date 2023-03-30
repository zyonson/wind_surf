FactoryBot.define do
  factory :micropost do
    title { "MyString" }
    content { "MyText" }
    association :user
    association :store
  end
end
