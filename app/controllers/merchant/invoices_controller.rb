class Merchant::InvoicesController < ApplicationController
  before_action :find_merchant

  def index
  end

  def show
    @invoice = Invoice.find(params[:id])
    @customer = Customer.find(@invoice.customer_id)
    @invoice_item = @invoice.invoice_items.first
    @item_name = Item.find(@invoice_item.item_id).name
  end

  private
  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end
