require "rails_helper"

RSpec.describe 'Merchant discount index ' do
  it "shows all the available discounts to a merchant" do
    mer_1 = create(:merchant)
    bulk_discount1 = create(:bulk_discount, merchant_id:mer_1.id)
    bulk_discount2 = create(:bulk_discount, merchant_id:mer_1.id)
    bulk_discount3 = create(:bulk_discount, merchant_id:mer_1.id)
    visit(merchant_dashboard_index_path(mer_1))
    expect(page).to have_link(merchant_discounts_path(mer_1))
  end
end
