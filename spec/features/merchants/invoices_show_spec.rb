require "rails_helper"
require 'time'
RSpec.describe 'Merchant Invoices index page' do

  it "brings us to invoice show page when clicked" do
    mer_1 = create(:merchant)
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

    invoice1 = create(:invoice, customer_id: cust_1.id)
    invoice2 = create(:invoice, customer_id: cust_2.id)
    invoice3 = create(:invoice, customer_id: cust_3.id)
    invoice4 = create(:invoice, customer_id: cust_4.id)
    invoice5 = create(:invoice, customer_id: cust_4.id)
    invoice6 = create(:invoice, customer_id: cust_4.id)
    invoice_item1 = create(:invoice_item, item_id:item_1.id, invoice_id:invoice1.id, quantity: 8, unit_price: 2, status: "shipped")
    invoice_item2 = create(:invoice_item, item_id:item_2.id, invoice_id:invoice2.id, quantity: 10, unit_price: 5)
    invoice_item3 = create(:invoice_item, item_id:item_2.id, invoice_id:invoice3.id, quantity: 5, unit_price: 2)
    invoice_item4 = create(:invoice_item, item_id:item_4.id, invoice_id:invoice4.id, quantity: 3, unit_price: 5)
    invoice_item4 = create(:invoice_item, item_id:item_5.id, invoice_id:invoice6.id, quantity: 3, unit_price: 5)
    invoice_item4 = create(:invoice_item, item_id:item_6.id, invoice_id:invoice5.id, quantity: 3, unit_price: 5)
    visit merchant_invoices_path(mer_1)
    expect(page).to have_link("#{invoice1.id}")
    click_link("#{invoice1.id}")
    expect(page).to have_content("#{invoice1.id}")
    expect(page).to have_content("#{invoice1.status}")
    expect(page).to have_content("#{invoice1.created_at.strftime("%A, %b %d, %Y")}")
    expect(page).to have_content("#{cust_1.first_name}")
    expect(page).to have_content("#{cust_1.last_name}")
  end

  it "shows our invoice item information on the invoice show page" do
    mer_1 = create(:merchant)
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

    invoice1 = create(:invoice, customer_id: cust_1.id)
    invoice2 = create(:invoice, customer_id: cust_2.id)
    invoice3 = create(:invoice, customer_id: cust_3.id)
    invoice4 = create(:invoice, customer_id: cust_4.id)
    invoice5 = create(:invoice, customer_id: cust_4.id)
    invoice6 = create(:invoice, customer_id: cust_4.id)
    invoice_item1 = create(:invoice_item, item_id:item_1.id, invoice_id:invoice1.id, quantity: 8, unit_price: 2, status: "shipped")
    invoice_item2 = create(:invoice_item, item_id:item_2.id, invoice_id:invoice2.id, quantity: 10, unit_price: 5)
    invoice_item3 = create(:invoice_item, item_id:item_2.id, invoice_id:invoice3.id, quantity: 5, unit_price: 2)
    invoice_item4 = create(:invoice_item, item_id:item_4.id, invoice_id:invoice4.id, quantity: 3, unit_price: 5)
    invoice_item4 = create(:invoice_item, item_id:item_5.id, invoice_id:invoice6.id, quantity: 3, unit_price: 5)
    invoice_item4 = create(:invoice_item, item_id:item_6.id, invoice_id:invoice5.id, quantity: 3, unit_price: 5)
    visit merchant_invoices_path(mer_1)
    expect(page).to have_link("#{invoice1.id}")
    click_link("#{invoice1.id}")
    expect(page).to have_content(item_1.name)
    expect(page).to have_content(invoice_item1.quantity)
    expect(page).to have_content(invoice_item1.unit_price)
    expect(page).to have_content(invoice_item1.status)
    expect(page).not_to have_content(item_6.name)
  end

  it "can display total revenue from invoice" do
    mer_1 = create(:merchant)
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

    invoice1 = create(:invoice, customer_id: cust_1.id)
    invoice2 = create(:invoice, customer_id: cust_2.id)
    invoice3 = create(:invoice, customer_id: cust_3.id)
    invoice4 = create(:invoice, customer_id: cust_4.id)
    invoice5 = create(:invoice, customer_id: cust_4.id)
    invoice6 = create(:invoice, customer_id: cust_4.id)
    invoice_item1 = create(:invoice_item, item_id:item_1.id, invoice_id:invoice1.id, quantity: 8, unit_price: 2, status: "shipped")
    invoice_item2 = create(:invoice_item, item_id:item_2.id, invoice_id:invoice1.id, quantity: 10, unit_price: 5)
    invoice_item3 = create(:invoice_item, item_id:item_2.id, invoice_id:invoice1.id, quantity: 5, unit_price: 2)
    invoice_item4 = create(:invoice_item, item_id:item_4.id, invoice_id:invoice4.id, quantity: 3, unit_price: 5)
    invoice_item4 = create(:invoice_item, item_id:item_5.id, invoice_id:invoice6.id, quantity: 3, unit_price: 5)
    invoice_item4 = create(:invoice_item, item_id:item_6.id, invoice_id:invoice5.id, quantity: 3, unit_price: 5)
    transaction1 = create(:transaction, invoice_id: invoice1.id, result: "success")

    visit merchant_invoice_path(mer_1, invoice1)

    expect(page).to have_content("Total Revenue from Invoice: 76")
  end

  it " " do
    mer_1 = create(:merchant)
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

    invoice1 = create(:invoice, customer_id: cust_1.id)
    invoice2 = create(:invoice, customer_id: cust_2.id)
    invoice3 = create(:invoice, customer_id: cust_3.id)
    invoice4 = create(:invoice, customer_id: cust_4.id)
    invoice5 = create(:invoice, customer_id: cust_4.id)
    invoice6 = create(:invoice, customer_id: cust_4.id)
    invoice_item1 = create(:invoice_item, item_id:item_1.id, invoice_id:invoice1.id, quantity: 8, unit_price: 2, status: "shipped")
    invoice_item2 = create(:invoice_item, item_id:item_2.id, invoice_id:invoice1.id, quantity: 10, unit_price: 5)
    invoice_item3 = create(:invoice_item, item_id:item_2.id, invoice_id:invoice1.id, quantity: 5, unit_price: 2)
    invoice_item4 = create(:invoice_item, item_id:item_4.id, invoice_id:invoice4.id, quantity: 3, unit_price: 5)
    invoice_item4 = create(:invoice_item, item_id:item_5.id, invoice_id:invoice6.id, quantity: 3, unit_price: 5)
    invoice_item4 = create(:invoice_item, item_id:item_6.id, invoice_id:invoice5.id, quantity: 3, unit_price: 5)
    transaction1 = create(:transaction, invoice_id: invoice1.id, result: "success")
    visit merchant_invoice_path(mer_1, invoice1)
     expect(page).to have_select("invoice_item[invoice_item_status]")
    select "packaged", from: "invoice_item[invoice_item_status]"
    expect(page).to have_button("Update Item Status")
    click_button("Update Item Status")
    expect(page).to have_select("invoice_item[invoice_item_status]")
  end

  it "shows the total revenue for my merchant and includes bulk discounts" do
    mer_1 = create(:merchant)
    bulk_discount1 = create(:bulk_discount, merchant_id: mer_1.id, percentage: 20, quantity:5)
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

    invoice1 = create(:invoice, customer_id: cust_1.id)
    invoice2 = create(:invoice, customer_id: cust_2.id)
    invoice3 = create(:invoice, customer_id: cust_3.id)
    invoice4 = create(:invoice, customer_id: cust_4.id)
    invoice5 = create(:invoice, customer_id: cust_4.id)
    invoice6 = create(:invoice, customer_id: cust_4.id)
    invoice_item1 = create(:invoice_item, item_id:item_1.id, invoice_id:invoice1.id, quantity: 8, unit_price: 2, status: "shipped")
    invoice_item2 = create(:invoice_item, item_id:item_2.id, invoice_id:invoice1.id, quantity: 10, unit_price: 5)
    invoice_item3 = create(:invoice_item, item_id:item_2.id, invoice_id:invoice1.id, quantity: 5, unit_price: 2)
    invoice_item4 = create(:invoice_item, item_id:item_4.id, invoice_id:invoice4.id, quantity: 3, unit_price: 5)
    invoice_item4 = create(:invoice_item, item_id:item_5.id, invoice_id:invoice6.id, quantity: 3, unit_price: 5)
    invoice_item4 = create(:invoice_item, item_id:item_6.id, invoice_id:invoice5.id, quantity: 3, unit_price: 5)
    transaction1 = create(:transaction, invoice_id: invoice1.id, result: "success")
    visit merchant_invoice_path(mer_1, invoice1)
    expect(page).to have_content("Revenue after Discounts: 60.8")

  end


  it "shows the link to applied discounts" do
    mer_1 = create(:merchant)
    bulk_discount1 = create(:bulk_discount, merchant_id: mer_1.id, percentage: 20, quantity:5)
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

    invoice1 = create(:invoice, customer_id: cust_1.id)
    invoice2 = create(:invoice, customer_id: cust_2.id)
    invoice3 = create(:invoice, customer_id: cust_3.id)
    invoice4 = create(:invoice, customer_id: cust_4.id)
    invoice5 = create(:invoice, customer_id: cust_4.id)
    invoice6 = create(:invoice, customer_id: cust_4.id)
    invoice_item1 = create(:invoice_item, item_id:item_1.id, invoice_id:invoice1.id, quantity: 8, unit_price: 2, status: "shipped")
    invoice_item2 = create(:invoice_item, item_id:item_2.id, invoice_id:invoice1.id, quantity: 10, unit_price: 5)
    invoice_item3 = create(:invoice_item, item_id:item_2.id, invoice_id:invoice1.id, quantity: 5, unit_price: 2)
    invoice_item4 = create(:invoice_item, item_id:item_4.id, invoice_id:invoice4.id, quantity: 3, unit_price: 5)
    invoice_item4 = create(:invoice_item, item_id:item_5.id, invoice_id:invoice6.id, quantity: 3, unit_price: 5)
    invoice_item4 = create(:invoice_item, item_id:item_6.id, invoice_id:invoice5.id, quantity: 3, unit_price: 5)
    transaction1 = create(:transaction, invoice_id: invoice1.id, result: "success")
    visit merchant_invoice_path(mer_1, invoice1)
    expect(page).to have_link("See Discount Applied")
    click_link("See Discount Applied")
    expect(page).to have_content(bulk_discount1.name)
    expect(page).to have_content(bulk_discount1.percentage)
    expect(page).to have_content(bulk_discount1.quantity)
  end

  it "does not show a link if no discount is applied" do
    mer_1 = create(:merchant)
    bulk_discount1 = create(:bulk_discount, merchant_id: mer_1.id, percentage: 20, quantity:50)
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

    invoice1 = create(:invoice, customer_id: cust_1.id)
    invoice2 = create(:invoice, customer_id: cust_2.id)
    invoice3 = create(:invoice, customer_id: cust_3.id)
    invoice4 = create(:invoice, customer_id: cust_4.id)
    invoice5 = create(:invoice, customer_id: cust_4.id)
    invoice6 = create(:invoice, customer_id: cust_4.id)
    invoice_item1 = create(:invoice_item, item_id:item_1.id, invoice_id:invoice1.id, quantity: 8, unit_price: 2, status: "shipped")
    invoice_item2 = create(:invoice_item, item_id:item_2.id, invoice_id:invoice1.id, quantity: 10, unit_price: 5)
    invoice_item3 = create(:invoice_item, item_id:item_2.id, invoice_id:invoice1.id, quantity: 5, unit_price: 2)
    invoice_item4 = create(:invoice_item, item_id:item_4.id, invoice_id:invoice4.id, quantity: 3, unit_price: 5)
    invoice_item4 = create(:invoice_item, item_id:item_5.id, invoice_id:invoice6.id, quantity: 3, unit_price: 5)
    invoice_item4 = create(:invoice_item, item_id:item_6.id, invoice_id:invoice5.id, quantity: 3, unit_price: 5)
    transaction1 = create(:transaction, invoice_id: invoice1.id, result: "success")
    visit merchant_invoice_path(mer_1, invoice1)
    expect(page).not_to have_link("See Discount Applied")
  end

  it "goes to the correct discount show page if multiple discounts are available for a merchant" do
    mer_1 = create(:merchant)
    bulk_discount1 = create(:bulk_discount, merchant_id: mer_1.id, percentage: 10, quantity:8)
    bulk_discount2 = create(:bulk_discount, merchant_id: mer_1.id, percentage: 20, quantity:10)
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

    invoice1 = create(:invoice, customer_id: cust_1.id)
    invoice2 = create(:invoice, customer_id: cust_2.id)
    invoice3 = create(:invoice, customer_id: cust_3.id)
    invoice4 = create(:invoice, customer_id: cust_4.id)
    invoice5 = create(:invoice, customer_id: cust_4.id)
    invoice6 = create(:invoice, customer_id: cust_4.id)
    invoice_item1 = create(:invoice_item, item_id:item_1.id, invoice_id:invoice1.id, quantity: 8, unit_price: 2, status: "shipped")
    invoice_item2 = create(:invoice_item, item_id:item_2.id, invoice_id:invoice1.id, quantity: 10, unit_price: 5)
    invoice_item3 = create(:invoice_item, item_id:item_2.id, invoice_id:invoice1.id, quantity: 5, unit_price: 2)
    invoice_item4 = create(:invoice_item, item_id:item_4.id, invoice_id:invoice4.id, quantity: 3, unit_price: 5)
    invoice_item4 = create(:invoice_item, item_id:item_5.id, invoice_id:invoice6.id, quantity: 3, unit_price: 5)
    invoice_item4 = create(:invoice_item, item_id:item_6.id, invoice_id:invoice5.id, quantity: 3, unit_price: 5)
    transaction1 = create(:transaction, invoice_id: invoice1.id, result: "success")
    visit merchant_invoice_path(mer_1, invoice1)
    expect(page).to have_link("See Discount Applied")
    click_link("See Discount Applied")
    expect(page).to have_content(bulk_discount1.name)
    expect(page).to have_content(bulk_discount1.percentage)
    expect(page).to have_content(bulk_discount1.quantity)
  end
end
