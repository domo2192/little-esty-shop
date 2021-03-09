require "rails_helper"

describe Invoice do
    before :each do
        @mer_1 = create(:merchant)
        @mer_2 = create(:merchant)
        @cust_1 = create(:customer)
        @cust_2 = create(:customer)
        @cust_3 = create(:customer)
        @cust_4 = create(:customer)
        @item_1 = create(:item, name: "item_1", merchant_id: @mer_1.id)
        @item_2 = create(:item, name: "item_2", merchant_id: @mer_1.id)
        @item_3 = create(:item, name: "item_3", merchant_id: @mer_1.id)
        @item_4 = create(:item, name:"item_4", merchant_id: @mer_1.id)
        @item_5 = create(:item, name:"item_5", merchant_id: @mer_2.id)
        @item_6 = create(:item, name:"item_6", merchant_id: @mer_2.id)

        @invoice1 = create(:invoice, customer_id: @cust_1.id)
        @invoice2 = create(:invoice, customer_id: @cust_2.id)
        @invoice3 = create(:invoice, customer_id: @cust_3.id)
        @invoice4 = create(:invoice, customer_id: @cust_4.id)
        @invoice5 = create(:invoice, customer_id: @cust_4.id)
        @invoice6 = create(:invoice, customer_id: @cust_4.id)
        invoice_item1 = create(:invoice_item, item_id:@item_1.id, invoice_id:@invoice1.id, quantity: 8, unit_price: 2, status: "shipped")
        invoice_item2 = create(:invoice_item, item_id:@item_2.id, invoice_id:@invoice1.id, quantity: 10, unit_price: 5, status: 2)
        invoice_item3 = create(:invoice_item, item_id:@item_2.id, invoice_id:@invoice1.id, quantity: 5, unit_price: 2, status: 2)
        invoice_item4 = create(:invoice_item, item_id:@item_4.id, invoice_id:@invoice2.id, quantity: 3, unit_price: 5, status: 0)
        invoice_item4 = create(:invoice_item, item_id:@item_5.id, invoice_id:@invoice2.id, quantity: 3, unit_price: 5, status: 0)
        invoice_item4 = create(:invoice_item, item_id:@item_6.id, invoice_id:@invoice2.id, quantity: 3, unit_price: 5, status: 0)
        transaction1 = create(:transaction, invoice_id: @invoice1.id, result: "success")
        transaction2 = create(:transaction, invoice_id: @invoice2.id, result: "success")
    end
  describe "relationships" do
    it { should belong_to :customer }
    it { should have_many :invoice_items }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many :transactions }
  end

  describe "class methods" do
    it "can display total revenue from a single invoice" do
      expect(Invoice.total_revenue(@invoice1.id)).to eq(76)
    end

    it "#incomplete_invoices" do
        expect(Invoice.incomplete_invoices.length).to eq(1)
        expect(Invoice.incomplete_invoices.first.id).to eq(@invoice2.id)
    end
  end

  it "can get all revenue of an invoice discounts to revenue" do
    expect(Invoice.total_revenue(@invoice1.id)).to eq(76)
    expect(Invoice.total_revenue(@invoice2.id)).to eq(45)
  end

  it "can discount from total revenue" do
    bulk_discount1 = create(:bulk_discount, merchant_id: @mer_1.id, percentage: 20, quantity:5)
    expect(@invoice1.discount).to eq(60.8)
  end

  it "edgecase testing for finding total revenue" do
    bulk_discount1 = create(:bulk_discount, merchant_id: @mer_1.id, percentage:10 , quantity:10)
    expect(@invoice1.discount).to eq(71)
  end

  it "more testing for total revenue with discounts" do
    InvoiceItem.destroy_all
    invoice_item1 = create(:invoice_item, item_id:@item_1.id, invoice_id:@invoice1.id, quantity: 12, unit_price: 1, status: "shipped")
    invoice_item2 = create(:invoice_item, item_id:@item_2.id, invoice_id:@invoice1.id, quantity: 15, unit_price: 1, status: 2)
    bulk_discount1 = create(:bulk_discount, merchant_id: @mer_1.id, percentage:20 , quantity:10)
    bulk_discount2 = create(:bulk_discount, merchant_id: @mer_1.id, percentage:30, quantity:15)
    expect(@invoice1.discount).to eq(20.1)

  end

  it "testing edgecases for total rev" do
    InvoiceItem.destroy_all
    invoice_item1 = create(:invoice_item, item_id:@item_1.id, invoice_id:@invoice1.id, quantity: 10, unit_price: 1, status: "shipped")
    invoice_item2 = create(:invoice_item, item_id:@item_2.id, invoice_id:@invoice1.id, quantity: 15, unit_price: 1, status: 2)
    bulk_discount1 = create(:bulk_discount, merchant_id: @mer_1.id, percentage:20 , quantity:10)
    bulk_discount2 = create(:bulk_discount, merchant_id: @mer_1.id, percentage:15, quantity:15)
    expect(@invoice1.discount).to eq(20)
  end
end
