class Merchant::BulkDiscountsController < ApplicationController
    before_action :find_merchant, only: [:index, :show, :new, :create]

  def index
    @json_holidays ||= GithubService.holidays
  end

  def show
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def new
  end

  def create
    @bulk_discount = @merchant.bulk_discounts.new(bulk_discounts_create_params)
    if @bulk_discount.save
      flash[:notice] = "#{@bulk_discount.name} was created"
      redirect_to merchant_bulk_discounts_path(@merchant)
    else
      flash[:notice] = "Enter Integers for both quantity and percentage"
      render :new
    end 
  end


  private
  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def bulk_discounts_create_params
    params.permit(:name, :percentage, :quantity)
  end
end
