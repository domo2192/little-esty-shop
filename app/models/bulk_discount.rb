class BulkDiscount < ApplicationRecord
  validates_presence_of :name
  validates_numericality_of :percentage
  validates_numericality_of :quantity
  belongs_to :merchant
  has_many :items, through: :merchant
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items

  def pending_invoices
    invoice_items.where(status: :pending)
  end
end
