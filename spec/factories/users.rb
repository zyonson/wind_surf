FactoryBot.define do
  factory :user do
    name  { 'aw' }
    sequence(:email) { |n| "assa#{n}@fty.c" }
    password { 'dottle-nouveau-pavilion-tights-furze' }
    password_confirmation { 'dottle-nouveau-pavilion-tights-furze' }
  end

  factory :admin, class: User do
    name { 'admin' }
    email { 'awa@gmail.com' }
    password { 'aaaaaa' }
    password_confirmation { 'aaaaaa' }
    admin { true }
  end
end
