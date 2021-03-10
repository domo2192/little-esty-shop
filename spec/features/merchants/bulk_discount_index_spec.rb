require "rails_helper"

RSpec.describe 'Merchant discount index ' do
  it "shows all the available discounts to a merchant" do
    mer_1 = create(:merchant)
    bulk_discount1 = create(:bulk_discount, merchant_id:mer_1.id)
    bulk_discount2 = create(:bulk_discount, merchant_id:mer_1.id)
    bulk_discount3 = create(:bulk_discount, merchant_id:mer_1.id)
    visit(merchant_dashboard_index_path(mer_1))
    expect(page).to have_link("Merchant Discounts")
    click_link("Merchant Discounts")
      within("#discounts-#{bulk_discount1.id}") do
        expect(page).to have_link(bulk_discount1.name)
        expect(page).to have_content(bulk_discount1.percentage)
        expect(page).to have_content(bulk_discount1.quantity)
      end
      within("#discounts-#{bulk_discount2.id}") do
        expect(page).to have_link(bulk_discount2.name)
        expect(page).to have_content(bulk_discount2.percentage)
        expect(page).to have_content(bulk_discount2.quantity)
      end
      within("#discounts-#{bulk_discount3.id}") do
      expect(page).to have_link(bulk_discount3.name)
      expect(page).to have_content(bulk_discount3.percentage)
      expect(page).to have_content(bulk_discount3.quantity)
    end
  end

  it "can click discount name and bring you to discount show" do
    mer_1 = create(:merchant)
    bulk_discount1 = create(:bulk_discount, merchant_id:mer_1.id)
    bulk_discount2 = create(:bulk_discount, merchant_id:mer_1.id)
    bulk_discount3 = create(:bulk_discount, merchant_id:mer_1.id)
    visit(merchant_bulk_discounts_path(mer_1))
      within("#discounts-#{bulk_discount1.id}") do
        expect(page).to have_link(bulk_discount1.name)
        click_link(bulk_discount1.name)
      end
        expect(current_path).to eq(merchant_bulk_discount_path(mer_1, bulk_discount1))
  end

  it "can show the api information for upcoming holidays" do
    mer_1 = create(:merchant)
    bulk_discount1 = create(:bulk_discount, merchant_id:mer_1.id)
    bulk_discount2 = create(:bulk_discount, merchant_id:mer_1.id)
    bulk_discount3 = create(:bulk_discount, merchant_id:mer_1.id)
    visit(merchant_bulk_discounts_path(mer_1))
    expect(page).to have_content("Upcoming Holidays")

    within("#upcomingholidays-") do
      expect(page).to have_content("Memorial Day")
      expect(page).to have_content("Independence Day")
      expect(page).to have_content("Labour Day")
    end
  end

  it "has a link to create a new bulk discount" do
      mer_1 = create(:merchant)
      visit(merchant_bulk_discounts_path(mer_1))
      expect(page).to have_content("Create New Bulk Discount")
      click_link("Create New Bulk Discount")
      expect(current_path).to eq(new_merchant_bulk_discount_path(mer_1))
  end

  it "has a link next to each bulk discount to delete it " do
    mer_1 = create(:merchant)
    cust_1 = create(:customer)
    bulk_discount1 = create(:bulk_discount, merchant_id:mer_1.id)
    bulk_discount2 = create(:bulk_discount, merchant_id:mer_1.id)
    bulk_discount3 = create(:bulk_discount, merchant_id:mer_1.id)
    item_1 = create(:item, name: "item_1", merchant_id: mer_1.id)
    invoice1 = create(:invoice, customer_id: cust_1.id)
    invoice_item1 = create(:invoice_item, item_id:item_1.id, invoice_id:invoice1.id, quantity: 8, unit_price: 2, status: "pending")
    invoice1 = create(:invoice, customer_id: cust_1.id)
      visit(merchant_bulk_discounts_path(mer_1))
      expect(page).to have_button("Delete #{bulk_discount1.name}")
      click_button("Delete #{bulk_discount1.name}")
      expect(page).not_to have_content(bulk_discount1.name)
      expect(page).not_to have_content(bulk_discount1.percentage)
      expect(current_path).to eq(merchant_bulk_discounts_path(mer_1))
  end

  it "does not have the button to delete if merchant has pending invoices" do
    mer_1 = create(:merchant)
    bulk_discount1 = create(:bulk_discount, merchant_id:mer_1.id)
    bulk_discount2 = create(:bulk_discount, merchant_id:mer_1.id)
    bulk_discount3 = create(:bulk_discount, merchant_id:mer_1.id)
    mer_2 = create(:merchant)
    cust_1 = create(:customer)
    cust_2 = create(:customer)
    cust_3 = create(:customer)
    cust_4 = create(:customer)
    item_1 = create(:item, name: "item_1", merchant_id: mer_1.id)
    item_2 = create(:item, name: "item_2", merchant_id: mer_1.id)
    item_3 = create(:item, name: "item_3", merchant_id: mer_1.id)
    item_4 = create(:item, name:"item_4", merchant_id: mer_1.id)
    item_5 = create(:item, name:"item_4", merchant_id: mer_2.id)
    item_6 = create(:item, name:"item_4", merchant_id: mer_2.id)

    invoice1 = create(:invoice, customer_id: cust_1.id, status: "in progress")
    invoice2 = create(:invoice, customer_id: cust_2.id)
    invoice3 = create(:invoice, customer_id: cust_3.id)
    invoice4 = create(:invoice, customer_id: cust_4.id)
    invoice5 = create(:invoice, customer_id: cust_4.id)
    invoice6 = create(:invoice, customer_id: cust_4.id)
    invoice_item1 = create(:invoice_item, item_id:item_1.id, invoice_id:invoice1.id, quantity: 8, unit_price: 2, status: 'pending')
    invoice_item2 = create(:invoice_item, item_id:item_2.id, invoice_id:invoice1.id, quantity: 10, unit_price: 5)
    invoice_item3 = create(:invoice_item, item_id:item_2.id, invoice_id:invoice1.id, quantity: 5, unit_price: 2)
    invoice_item4 = create(:invoice_item, item_id:item_4.id, invoice_id:invoice4.id, quantity: 3, unit_price: 5)
    invoice_item4 = create(:invoice_item, item_id:item_5.id, invoice_id:invoice6.id, quantity: 3, unit_price: 5)
    invoice_item4 = create(:invoice_item, item_id:item_6.id, invoice_id:invoice5.id, quantity: 3, unit_price: 5)
    transaction1 = create(:transaction, invoice_id: invoice1.id, result: "success")
      visit(merchant_bulk_discounts_path(mer_1))
      expect(page).not_to have_link("Delete #{bulk_discount1.name}")
  end
end
