# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

BulkDiscount.create(name: "discount 1", merchant_id: 1, percentage: 10, quantity:8)
BulkDiscount.create(name: "discount 2", merchant_id: 2, percentage: 20, quantity:10)
BulkDiscount.create(name: "discount 3", merchant_id: 3, percentage: 10, quantity:10)
BulkDiscount.create(name: "discount 4", merchant_id: 4, percentage: 10, quantity:10)
BulkDiscount.create(name: "discount 5", merchant_id: 5, percentage: 10, quantity:10)
BulkDiscount.create(name: "discount 6", merchant_id: 6, percentage: 10, quantity:10)
BulkDiscount.create(name: "discount 7", merchant_id: 7, percentage: 10, quantity:10)
BulkDiscount.create(name: "discount 8", merchant_id: 8, percentage: 10, quantity:10)
BulkDiscount.create(name: "discount 8", merchant_id: 1, percentage: 20, quantity:15)
Merchant.create(name: "Dominic", id:101)
BulkDiscount.create(name: "Dominics Discount", merchant_id: 101, percentage: 20, quantity:15)
