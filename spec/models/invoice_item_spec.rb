require "rails_helper"

describe InvoiceItem do
	before :each do
		@mer_1 = create(:merchant)
		@cust_1 = create(:customer, first_name: "A", last_name: "1")
		@cust_2 = create(:customer, first_name: "B", last_name: "1")
		@item_1 = create(:item, merchant_id: @mer_1.id)
		@item_2 = create(:item, merchant_id: @mer_1.id)
		@invoice1 = create(:invoice, customer_id: @cust_1.id)
		@invoice2 = create(:invoice, customer_id: @cust_2.id)
		@invoice_item1 = create(:invoice_item, item_id:@item_1.id, invoice_id:@invoice1.id)
		@invoice_item2 = create(:invoice_item, item_id:@item_2.id, invoice_id:@invoice2.id)
		@transaction1 = create(:transaction, result: "success", invoice_id: @invoice1.id)
		@transaction2 = create(:transaction, result: "success", invoice_id: @invoice1.id)
		@transaction2 = create(:transaction, result: "success", invoice_id: @invoice2.id)
		@transaction2 = create(:transaction, result: "success", invoice_id: @invoice2.id)
	end
  describe "relationships" do
    it { should belong_to :invoice }
    it { should belong_to :item }
  	it { should have_many(:transactions).through(:invoice) }
  	it { should have_one(:merchant).through(:item) }
  	it { should have_one(:customer).through(:invoice) }
  	it { should have_many(:bulk_discounts).through(:merchant) }

  end
  describe "class methods" do
  	it "::items_by_invoice" do
  		expect(InvoiceItem.items_by_invoice(@invoice1.id).length).to eq(1)
  	end
  	it "::merchants_best_day" do
  		expect(@invoice_item1.merchants_best_day(@mer_1.id).length).to eq(1)
  		expect(@invoice_item1.merchants_best_day(@mer_1.id).first.id).to eq(@mer_1.id)
  	end
  end

	it "can find the bulk discount of a single invoice_item" do
		InvoiceItem.destroy_all
		invoice_item1 = create(:invoice_item, invoice_id: @invoice1.id, item_id: @item_1.id, quantity: 5, unit_price: 10)
		bulk_discount1 = create(:bulk_discount, merchant_id: @mer_1.id, percentage: 20, quantity:5)
		expect(invoice_item1.discounted).to eq(40)
	end

end
