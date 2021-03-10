class Merchant::BulkDiscountsController < ApplicationController
    before_action :find_merchant, only: [:index, :show, :new, :create, :destroy, :edit, :update]
    before_action :find_discount, only: [:show, :destroy, :edit, :update]

  def index
    @json_holiday_names ||= GithubService.holiday_names
    @json_holiday_dates ||= GithubService.holiday_dates
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
      flash[:notice] = "Missing required field. Use integers for quanitity and percentage"
      render :new
    end
  end

  def edit
  end

  def update
    if @bulk_discount.update(update_bulk_discount_params)
      flash[:notice] = "#{@bulk_discount.name} was updated"
      redirect_to merchant_bulk_discount_path(@merchant, @bulk_discount)
    else
      flash[:notice] = "Enter Integers for both quantity and percentage and word for name"
      render :edit
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

  def update_bulk_discount_params
    params.require(:bulk_discount).permit(:name, :percentage, :quantity)
  end
end
