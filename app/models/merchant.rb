class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  def top_five_customers
    transactions.joins(invoice: :customer).select("customers.*, COUNT(transactions) AS count_of_success, customers.id AS customer_id").where("transactions.result = ?", 'success').group("customers.id").order("count_of_success DESC").limit(5)
  end

  def self.enabled_merchants
    where("status = 'enabled'")
  end 

  def self.disabled_merchants
    where("status = 'disabled'")
  end

end
