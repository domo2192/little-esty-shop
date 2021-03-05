class Merchant::BulkDiscountsController < ApplicationController
    before_action :find_merchant, only: [:index, :show]

  def index
  end

  def show
    @bulk_discount = BulkDiscount.find(params[:id])
  end


  private
  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end
