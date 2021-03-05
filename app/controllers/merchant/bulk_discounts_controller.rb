class Merchant::BulkDiscountsController < ApplicationController
    before_action :find_merchant, only: [:index, :show, :new, :create, :destroy]
    before_action :find_discount, only: [:show, :destroy]

  def index
    @json_holidays ||= GithubService.holidays
  end

  def show
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

  def destroy
    BulkDiscount.destroy(@bulk_discount.id)
    redirect_to merchant_bulk_discounts_path(@merchant)
  end


  private
  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def find_discount
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def bulk_discounts_create_params
    params.permit(:name, :percentage, :quantity)
  end
end
