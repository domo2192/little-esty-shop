class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  has_many :transactions, through: :invoice
  has_one :merchant, through: :item
  has_one :customer, through: :invoice
  has_many :bulk_discounts, through: :merchant

  enum status: [:pending, :packaged, :shipped]

  def self.items_by_invoice(invoice_id)
    joins(:invoice, :item).select('items.name', 'invoice_items.quantity', 'invoice_items.unit_price', 'invoice_items.status', 'invoices.id').where("invoices.id = #{invoice_id}")
  end

  def merchants_best_day(merchant_in_question)
    InvoiceItem.joins("JOIN invoices ON invoice_items.invoice_id = invoices.id JOIN items ON invoice_items.item_id = items.id JOIN transactions ON transactions.invoice_id = invoices.id JOIN merchants ON merchants.id = items.merchant_id").where("transactions.result = 'success' AND invoices.status != 0 AND merchants.id = #{merchant_in_question}").group("merchants.id, DATE_TRUNC('day',invoices.created_at)").select("merchants.id, DATE_TRUNC('day',invoices.created_at) AS date, merchants.name , SUM (invoice_items.quantity * invoice_items.unit_price) AS revenue").order("revenue DESC, date DESC").limit(1)
  end

  def revenue
    (unit_price * quantity).to_f
  end

  def discounted
    return revenue if discount_from_total.nil?
     revenue - (revenue * (discount_from_total.percentage.to_f/100))
   end
  end

  def discount_from_total
    bulk_discounts.where('? >= quantity', self.quantity).order(percentage: :desc, quantity: :desc).first
  end
