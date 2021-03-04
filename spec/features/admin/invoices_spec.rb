require "rails_helper"

RSpec.describe "As an admin" do
	before :each do
		@mer_1 = create(:merchant)
		@mer_2 = create(:merchant)
		@mer_3 = create(:merchant)
		@mer_4 = create(:merchant)
		@mer_5 = create(:merchant)
		@cust_1 = create(:customer, first_name: "A", last_name: "1")
		@cust_2 = create(:customer, first_name: "B", last_name: "1")
		@cust_3 = create(:customer, first_name: "C", last_name: "1")
		@cust_4 = create(:customer, first_name: "D", last_name: "1")
				@item_1 = create(:item, merchant_id: @mer_1.id)
		@item_2 = create(:item, merchant_id: @mer_1.id)
		@item_3 = create(:item, merchant_id: @mer_1.id)
		@item_4 = create(:item, merchant_id: @mer_1.id)
				@item_5 = create(:item, merchant_id: @mer_2.id)
		@item_6 = create(:item, merchant_id: @mer_2.id)
		@item_7 = create(:item, merchant_id: @mer_2.id)
		@item_8 = create(:item, merchant_id: @mer_2.id)
				@item_9 = create(:item, merchant_id: @mer_3.id)
		@item_10 = create(:item, merchant_id: @mer_3.id)
		@item_11 = create(:item, merchant_id: @mer_3.id)
		@item_12 = create(:item, merchant_id: @mer_3.id)
				@item_13 = create(:item, merchant_id: @mer_4.id)
		@item_14 = create(:item, merchant_id: @mer_4.id)
		@item_15 = create(:item, merchant_id: @mer_4.id)
		@item_16 = create(:item, merchant_id: @mer_4.id)
				@item_17 = create(:item, merchant_id: @mer_5.id)
		@item_18 = create(:item, merchant_id: @mer_5.id)
		@item_19 = create(:item, merchant_id: @mer_5.id)
		@item_20 = create(:item, merchant_id: @mer_5.id)
		
		@invoice1 = create(:invoice, customer_id: @cust_1.id)
		@invoice2 = create(:invoice, customer_id: @cust_2.id)
		@invoice3 = create(:invoice, customer_id: @cust_3.id)
		@invoice4 = create(:invoice, customer_id: @cust_4.id)
		@invoice_item1 = create(:invoice_item, status: 0 ,item_id:@item_1.id, invoice_id:@invoice1.id)
		@invoice_item2 = create(:invoice_item, status: 0 , item_id:@item_2.id, invoice_id:@invoice2.id)
		@invoice_item3 = create(:invoice_item, status: 0 , item_id:@item_3.id, invoice_id:@invoice3.id)
		@invoice_item4 = create(:invoice_item, item_id:@item_4.id, invoice_id:@invoice4.id)
				@invoice_item11 = create(:invoice_item, status: 0 ,item_id:@item_5.id, invoice_id:@invoice1.id)
		@invoice_item12 = create(:invoice_item, status: 0 , item_id:@item_6.id, invoice_id:@invoice2.id)
		@invoice_item13 = create(:invoice_item, status: 0 , item_id:@item_7.id, invoice_id:@invoice3.id)
		@invoice_item14 = create(:invoice_item, item_id:@item_8.id, invoice_id:@invoice4.id)
				@invoice_item21 = create(:invoice_item, status: 0 ,item_id:@item_9.id, invoice_id:@invoice1.id)
		@invoice_item22 = create(:invoice_item, status: 0 , item_id:@item_10.id, invoice_id:@invoice2.id)
		@invoice_item23 = create(:invoice_item, status: 0 , item_id:@item_11.id, invoice_id:@invoice3.id)
		@invoice_item24 = create(:invoice_item, item_id:@item_12.id, invoice_id:@invoice4.id)
				@invoice_item31 = create(:invoice_item, status: 0 ,item_id:@item_13.id, invoice_id:@invoice1.id)
		@invoice_item32 = create(:invoice_item, status: 0 , item_id:@item_14.id, invoice_id:@invoice2.id)
		@invoice_item33 = create(:invoice_item, status: 0 , item_id:@item_15.id, invoice_id:@invoice3.id)
		@invoice_item34 = create(:invoice_item, item_id:@item_16.id, invoice_id:@invoice4.id)
				@invoice_item41 = create(:invoice_item, status: 0 ,item_id:@item_17.id, invoice_id:@invoice1.id)
		@invoice_item42 = create(:invoice_item, status: 0 , item_id:@item_18.id, invoice_id:@invoice2.id)
		@invoice_item43 = create(:invoice_item, status: 0 , item_id:@item_19.id, invoice_id:@invoice3.id)
		@invoice_item44 = create(:invoice_item, item_id:@item_20.id, invoice_id:@invoice4.id)
		
		@transaction1 = create(:transaction, result: "success", invoice_id: @invoice1.id)
		@transaction2 = create(:transaction, result: "failed", invoice_id: @invoice1.id)
		@transaction2 = create(:transaction, result: "success", invoice_id: @invoice2.id)
		@transaction2 = create(:transaction, result: "success", invoice_id: @invoice2.id)
		@transaction3 = create(:transaction, result: "success", invoice_id: @invoice1.id)
		@transaction4 = create(:transaction, result: "success", invoice_id: @invoice4.id)
		@transaction6 = create(:transaction, result: "success", invoice_id: @invoice3.id)
		@transaction7 = create(:transaction, result: "success", invoice_id: @invoice3.id)
	end
	describe " the admin Invoices index" do
		it "shows a list of all the invoices in the system" do
			visit "/admin/invoices"
			expect(page).to have_link("#{@invoice1.id}")
			expect(page).to have_link("#{@invoice2.id}")
			expect(page).to have_link("#{@invoice3.id}")
			expect(page).to have_link("#{@invoice4.id}")

			click_on "#{@invoice1.id}"
			expect(current_path).to eq("/admin/invoices/#{@invoice1.id}")
		end

		describe "the admin Invoices show page" do
			it "shows all the information about an invoice" do
				visit "/admin/invoices/#{@invoice1.id}"
				expect(page).to have_content("Invoice #{@invoice1.id}")
				expect(page).to have_select("status")
    		select "cancelled", from: "status"
    		expect(page).to have_button("Update Invoice Status")
    		click_button("Update Invoice Status")
    	
		
				expect(page).to have_content("Item name: #{@item_1.name}, Quantity ordered: 10, Sold for: $2.00 per unit, Status: pending")
				expect(page).to have_content("Item name: #{@item_5.name}, Quantity ordered: 10, Sold for: $2.00 per unit, Status: pending")
				expect(page).to have_content("Item name: #{@item_9.name}, Quantity ordered: 10, Sold for: $2.00 per unit, Status: pending")
				expect(page).to have_content("Item name: #{@item_13.name}, Quantity ordered: 10, Sold for: $2.00 per unit, Status: pending")
				expect(page).to have_content("Item name: #{@item_17.name}, Quantity ordered: 10, Sold for: $2.00 per unit, Status: pending")
				expect(page).to have_content("Invoice Total: $100.00")

			end
		end
	end
end	