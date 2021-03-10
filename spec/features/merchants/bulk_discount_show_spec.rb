require "rails_helper"

RSpec.describe 'Merchant discount show' do
  it "shows the quantity threshold and and percentage of discount" do
    mer_1 = create(:merchant)
    bulk_discount1 = create(:bulk_discount, merchant_id:mer_1.id)
    visit(merchant_bulk_discount_path(mer_1, bulk_discount1))
    expect(page).to have_content(bulk_discount1.name)
    expect(page).to have_content(bulk_discount1.percentage)
    expect(page).to have_content(bulk_discount1.quantity)
  end

  it "shows a link to edit the bulk discount and takes me to the edit form" do
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
    expect(current_path).to eq(edit_merchant_bulk_discount_path(mer_1, bulk_discount1))
  end

  it "you are unable to delete or edit a bulk discount if the invoice is pending" do
    mer_1 = create(:merchant)
    bulk_discount1 = create(:bulk_discount, merchant_id: mer_1.id, percentage: 10, quantity:8)
    bulk_discount1 = create(:bulk_discount, merchant_id: mer_1.id, percentage: 20, quantity:10)
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
    invoice_item1 = create(:invoice_item, item_id:item_1.id, invoice_id:invoice1.id, quantity: 8, unit_price: 2)
    invoice_item2 = create(:invoice_item, item_id:item_2.id, invoice_id:invoice1.id, quantity: 10, unit_price: 5)
    invoice_item3 = create(:invoice_item, item_id:item_2.id, invoice_id:invoice1.id, quantity: 5, unit_price: 2)
    invoice_item4 = create(:invoice_item, item_id:item_4.id, invoice_id:invoice4.id, quantity: 3, unit_price: 5)
    invoice_item4 = create(:invoice_item, item_id:item_5.id, invoice_id:invoice6.id, quantity: 3, unit_price: 5)
    invoice_item4 = create(:invoice_item, item_id:item_6.id, invoice_id:invoice5.id, quantity: 3, unit_price: 5)
    transaction1 = create(:transaction, invoice_id: invoice1.id, result: "success")
    visit(merchant_bulk_discount_path(mer_1, bulk_discount1))
    expect(page).not_to have_link("Edit this bulk discount")
    expect(page).to have_content("You can edit this discount once you complete your pending invoices")
  end
end
