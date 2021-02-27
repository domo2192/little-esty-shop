class Admin::InvoicesController < ApplicationController
	def index
		@invoices = Invoice.all
	end

	def show
		@invoice = Invoice.find(params[:id])
		@customer = Customer.find(@invoice.customer_id)
		invoice_id = @invoice.id
		@items = InvoiceItem.items_by_invoice(invoice_id)
		@revenue = @items.sum('invoice_items.quantity * invoice_items.unit_price')
	end

end
