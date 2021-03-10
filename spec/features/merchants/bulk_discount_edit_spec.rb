require "rails_helper"

RSpec.describe 'Merchant discount show' do
  it "shows the quantity threshold and and percentage of discount" do
    mer_1 = create(:merchant)
    cust_1 = create(:customer)
    bulk_discount1 = create(:bulk_discount, merchant_id:mer_1.id)
    bulk_discount2 = create(:bulk_discount, merchant_id:mer_1.id)
    bulk_discount3 = create(:bulk_discount, merchant_id:mer_1.id)
    item_1 = create(:item, name: "item_1", merchant_id: mer_1.id)
    invoice1 = create(:invoice, customer_id: cust_1.id)
    invoice_item1 = create(:invoice_item, item_id:item_1.id, invoice_id:invoice1.id, quantity: 8, unit_price: 2, status: "pending")
    invoice1 = create(:invoice, customer_id: cust_1.id)
    visit(merchant_bulk_discount_path(mer_1, bulk_discount1))
    expect(page).to have_link("Edit this bulk discount")
    click_link("Edit this bulk discount")
    fill_in :bulk_discount_name, with: "Bulk Discount 4"
    fill_in :bulk_discount_percentage, with: 2.5
    fill_in :bulk_discount_quantity, with: 10
    click_button("Edit Bulk Discount")
    expect(page).to have_content("Bulk Discount 4")
    expect(page).to have_content(2.5)
    expect(page).to have_content(10)
    expect(page).to have_content("Bulk Discount 4 was updated")
  end

  it "can update single attributes and not break" do
    mer_1 = create(:merchant)
    cust_1 = create(:customer)
    bulk_discount1 = create(:bulk_discount, merchant_id:mer_1.id)
    bulk_discount2 = create(:bulk_discount, merchant_id:mer_1.id)
    bulk_discount3 = create(:bulk_discount, merchant_id:mer_1.id)
    item_1 = create(:item, name: "item_1", merchant_id: mer_1.id)
    invoice1 = create(:invoice, customer_id: cust_1.id)
    invoice_item1 = create(:invoice_item, item_id:item_1.id, invoice_id:invoice1.id, quantity: 8, unit_price: 2, status: "pending")
    invoice1 = create(:invoice, customer_id: cust_1.id)
    visit(merchant_bulk_discount_path(mer_1, bulk_discount1))
    click_link("Edit this bulk discount")
    fill_in :bulk_discount_percentage, with: 2.5
    click_button("Edit Bulk Discount")
    expect(page).to have_content("#{bulk_discount1.name} was updated")
    expect(page).to have_content("#{bulk_discount1.quantity}")
    expect(page).to have_content("#{bulk_discount1.name}")
    expect(page).to have_content(2.5)
  end

  it "can update two attributes and not break" do
    mer_1 = create(:merchant)
    cust_1 = create(:customer)
    bulk_discount1 = create(:bulk_discount, merchant_id:mer_1.id)
    bulk_discount2 = create(:bulk_discount, merchant_id:mer_1.id)
    bulk_discount3 = create(:bulk_discount, merchant_id:mer_1.id)
    item_1 = create(:item, name: "item_1", merchant_id: mer_1.id)
    invoice1 = create(:invoice, customer_id: cust_1.id)
    invoice_item1 = create(:invoice_item, item_id:item_1.id, invoice_id:invoice1.id, quantity: 8, unit_price: 2, status: "pending")
    invoice1 = create(:invoice, customer_id: cust_1.id)
    visit(merchant_bulk_discount_path(mer_1, bulk_discount1))
    click_link("Edit this bulk discount")
    fill_in :bulk_discount_percentage, with: 2.5
    fill_in :bulk_discount_quantity, with: 10
    click_button("Edit Bulk Discount")
    expect(page).to have_content(2.5)
    expect(page).to have_content(10)
    expect(page).to have_content("#{bulk_discount1.name}")
    expect(page).to have_content("#{bulk_discount1.name} was updated")
  end

  it "will break if you put in the wrong data type" do
    mer_1 = create(:merchant)
    cust_1 = create(:customer)
    bulk_discount1 = create(:bulk_discount, merchant_id:mer_1.id)
    bulk_discount2 = create(:bulk_discount, merchant_id:mer_1.id)
    bulk_discount3 = create(:bulk_discount, merchant_id:mer_1.id)
    item_1 = create(:item, name: "item_1", merchant_id: mer_1.id)
    invoice1 = create(:invoice, customer_id: cust_1.id)
    invoice_item1 = create(:invoice_item, item_id:item_1.id, invoice_id:invoice1.id, quantity: 8, unit_price: 2, status: "pending")
    invoice1 = create(:invoice, customer_id: cust_1.id)
    visit(merchant_bulk_discount_path(mer_1, bulk_discount1))
    click_link("Edit this bulk discount")
    fill_in :bulk_discount_percentage, with: 2.5
    fill_in :bulk_discount_quantity, with: "ten"
    click_button("Edit Bulk Discount")
    expect(page).to have_content("Enter Integers for both quantity and percentage and word for name")
  end
end
