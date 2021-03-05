require "rails_helper"

RSpec.describe 'Merchant discount index ' do
  it "shows all the available discounts to a merchant" do
    mer_1 = create(:merchant)
    bulk_discount1 = mer_1.bulk_discount.create(name:"A", percentage:10.0, quantity: 10)
    bulk_discount2 = mer_1.bulk_discount.create(name:"B", percentage:5.0, quantity: 5)
    bulk_discount3 = mer_1.bulk_discount.create(name:"C", percentage:15.0, quantity: 20)
    visit(merchant_dashboard_index_path(mer_1))
    expect(page).to have_link(merchant_discounts_path(mer_1))
  end
end
