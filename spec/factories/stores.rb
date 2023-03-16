FactoryBot.define do
  factory :store do
    store_name { "gg" }
    address { "MyString" }
    phone_number { "09090909090" }
    boat_house { "MyString" }
    price { 1 }
    day { "MyString" }
    time { "MyString" }
    after(:build) do |store|
      store.image.attach(io: File.open(
        Rails.root.join('app', 'assets', 'images', 'default_store.jpg')
      ), filename: 'default_store.jpg')
    end
  end
end
