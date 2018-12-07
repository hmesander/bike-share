class CartsController < ApplicationController
  include ActionView::Helpers::TextHelper

  def show
  end

  def create
    item = Item.find(params[:item_id])
    if item.status == 'retired'
      flash[:error] = "Accessory Retired!"
    else
      @basket.add_item(item.id)
      session[:cart] = @basket.contents

      flash[:notice] = t('.success', items: pluralize(@basket.count_of(item.id), item.title))
    end
    redirect_to bike_shop_path
  end

  def update
    @basket.update_item(params[:item], params[:quantity])
    flash[:notice] = t('.notice')
    redirect_to cart_path
  end

  def destroy
    @basket.remove(params[:item])
    item = Item.find(params[:item].to_i)
    flash[:success] = t('.success', item_path: item_path(item), item: item.title)
    redirect_to cart_path
  end
end
