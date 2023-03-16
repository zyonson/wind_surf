FactoryBot.define do
  factory :user do
    name  { 'awoooooo' }
    sequence(:email) { |n| "assa#{n}@fty.c" }
    password { 'dottle-nouveau-pavilion-tights-furze' }
    password_confirmation { 'dottle-nouveau-pavilion-tights-furze' }
    after(:build) do |user|
      user.avatar.attach(io: File.open(
        Rails.root.join('app', 'assets', 'images', 'default_icon.jpg')
      ), filename: 'default_icon.jpg')
    end
  end

  factory :admin, class: User do
    name { 'admin' }
    email { 'awa@gmail.com' }
    password { 'aaaaaa' }
    password_confirmation { 'aaaaaa' }
    admin { true }
    after(:build) do |user|
      user.avatar.attach(io: File.open(
        Rails.root.join('app', 'assets', 'images', 'default_icon.jpg')
      ), filename: 'default_icon.jpg')
    end
  end
end
