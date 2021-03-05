require "faker"
FactoryBot.define do
  factory :bulk_discount do
    name { Faker::Name.unique.name }
    percentage { Faker::Commerce.price(range: 5..20.0) }
    quantity  { Faker::Commerce.price(range: 5..15) }
  end
end
