require "rails_helper"

RSpec.describe 'Merchant discount show' do
  it "shows the quantity threshold and and percentage of discount" do
    mer_1 = create(:merchant)
    bulk_discount1 = create(:bulk_discount, merchant_id:mer_1.id)
    visit()
  end
end
