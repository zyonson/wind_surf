FactoryBot.define do
  factory :user do
    name  { 'aw' }
    sequence(:email) { |n| "assa#{n}@fty.c" }
    password { 'dottle-nouveau-pavilion-tights-furze' }
    password_confirmation { 'dottle-nouveau-pavilion-tights-furze' }
  end
end
