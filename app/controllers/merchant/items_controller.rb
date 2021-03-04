class Merchant::ItemsController < ApplicationController
  before_action :find_merchant, only: [:show, :edit, :index, :update, :create, :new]
  before_action :find_item, only: [:show, :edit]

  def index
    @enabled_items = @merchant.items.enabled_items
    @disabled_items = @merchant.items.disabled_items
    @top_items = @merchant.top_five_items
  end

  def show
  end

  def edit
  end

  def update
    item = Item.find(params[:id])
    if params[:item_status] != nil
      item.change_status(params[:item_status])
      redirect_to merchant_items_path(@merchant)
    else
      if item.update(item_params)
        flash.notice = "Item Updated"
      redirect_to merchant_item_path(params[:merchant_id], item)
      else
        flash[:error] = "Fill in unit price with integer, description with statement"
        @item = Item.find(params[:id])
        render :edit
      end
    end
  end

  def new
  end

  def create
    @item = @merchant.items.new(item_create_params)
    @item.save
    redirect_to merchant_items_path(@merchant)
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :item_status)
  end

  def item_create_params
    params.permit(:name, :description, :unit_price, :item_status)
  end

  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def find_item
    @item = Item.find(params[:id])
  end
end
