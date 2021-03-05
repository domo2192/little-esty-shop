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
    expect(page).to have_link(bulk_discount1.name)
    expect(page).to have_link(bulk_discount2.name)
    expect(page).to have_link(bulk_discount3.name)
    expect(page).to have_content(bulk_discount1.percentage)
    expect(page).to have_content(bulk_discount1.quantity)
    expect(page).to have_content(bulk_discount2.percentage)
    expect(page).to have_content(bulk_discount2.quantity)
    expect(page).to have_content(bulk_discount3.percentage)
    expect(page).to have_content(bulk_discount3.quantity)
  end

  it "can click discount name and bring you to discount show" do
    mer_1 = create(:merchant)
    bulk_discount1 = create(:bulk_discount, merchant_id:mer_1.id)
    bulk_discount2 = create(:bulk_discount, merchant_id:mer_1.id)
    bulk_discount3 = create(:bulk_discount, merchant_id:mer_1.id)
    visit(merchant_bulk_discounts_path(mer_1))
    expect(page).to have_link(bulk_discount1.name)
    click_link(bulk_discount1.name)
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
end
