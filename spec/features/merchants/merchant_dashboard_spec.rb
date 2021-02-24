require "rails_helper"

RSpec.describe 'Merchant Dashboard' do
  before :each do
    @mer_1 = create(:merchant)
    @mer_2 = create(:merchant, name: "Target" )
  end

  it "shows merchant names on the dashboard" do
    visit merchant_dashboard_index_path(@mer_1)

    expect(page).to have_content("#{@mer_1.name}")
  end

  it "shows links to the merchant's items and invoices index" do
    visit merchant_dashboard_index_path(@mer_1)

    expect(page).to have_link(merchant_items_path(@mer_1))
    expect(page).to have_link(merchant_invoices_path(@mer_1))
  end
end
