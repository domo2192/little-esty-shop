class BulkDiscount < ApplicationRecord
  validates_presence_of :name
  validates_numericality_of :percentage
  validates_numericality_of :quantity
  belongs_to :merchant
end 
