# frozen_string_literal: true

class OrdersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :fetch_order, only: %i[index show edit update]

  def index
    @orders = Order.all
  end

  def show
  end

  def new
    @order = Order.new
  end

  def edit; end

  def create
    @order = Order.new(order_params)

    if @order.save
      redirect_to @order, notice: "Pedido foi criado com sucesso."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    return render @order if @order.update(order_params)
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :delivery_address_id, :total_price, :freight_price, :status, :coupon_id)
  end

  def fetch_order
    @order = Order.find(params[:id])
  end
end
