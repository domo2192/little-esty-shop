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
    bulk_discount1 = create(:bulk_discount, merchant_id:mer_1.id)
    visit(merchant_bulk_discount_path(mer_1, bulk_discount1))
    expect(page).to have_link("Edit this bulk discount")
    click_link("Edit this bulk discount")
    expect(current_path).to eq(edit_merchant_bulk_discount_path(mer_1, bulk_discount1))
  end
end
