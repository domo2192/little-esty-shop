require "rails_helper"

RSpec.describe 'Merchant bulk discount new' do
  it "shows all the available discounts to a merchant" do
      mer_1 = create(:merchant)
      visit(new_merchant_bulk_discount_path(mer_1))
      expect(page).to have_content("Create Bulk Discount")
      fill_in :name, with: "Bulk Discount 4"
      fill_in :percentage, with: 9.5
      fill_in :quantity, with: 10
      click_button("Create Bulk Discount")
      expect(page).to have_link("Bulk Discount 4")
      expect(page).to have_content(9.5)
      expect(page).to have_content(10)
      expect(page).to have_content("Bulk Discount 4 was created")
  end

  it "has sad paths if data is not input correctly" do
    mer_1 = create(:merchant)
    visit(new_merchant_bulk_discount_path(mer_1))
    expect(page).to have_content("Create Bulk Discount")
    fill_in :name, with: "Bulk Discount 4"
    fill_in :percentage, with: "number"
    fill_in :quantity, with: "number"
    click_button("Create Bulk Discount")
    expect(page).to have_content("Missing required field. Use integers for quanitity and percentage")
  end
end
