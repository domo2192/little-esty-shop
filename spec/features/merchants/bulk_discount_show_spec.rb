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
end
