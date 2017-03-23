class OrdersController < ApplicationController
  before_action :authenticate_account!

  def index
    @orders = case params[:filter]
      when {account: "requester"}
        [
          current_account.requests.available,
          current_account.requests.finished,
          current_account.requests.canceled
        ].map(&:chronological).flatten
      when {"priority" => "urgent"}
        Order.available.urgent.chronological

      when {"state" => "finished"}
        Order.finished.chronological

      when {"day" => "today"}
        Order.created_on(Date.today).chronological

      when {"day" => "yesterday"}
        Order.created_on(Date.yesterday).chronological

      when "all"
        [
          Order.available,
          Order.finished,
          Order.canceled
        ].map(&:chronological).flatten

      else
        Order.available.chronological
    end
  end

  def show
    @order = Order.find_by!(id: params[:id])
  end

  def new
    @order = current_account.requests.build
  end

  def create
    @order = current_account.requests.create(orders_attributes)

    if @order.save
      if @order.urgent?
        Account.watchers.each do |watcher|
          OrdersMailer.urgent(watcher, @order).deliver
        end
      end
      redirect_to :root
    else
      render :new
    end
  end

  def finish
    @order = Order.find_by!(id: params[:id])
    @order.owner = current_account

    if @order.finish && @order.save
      OrdersMailer.finished(current_account, @order).deliver

      redirect_to :root
    else
      redirect_to order_path(@order)
    end
  end

  def cancel
    @order = Order.find_by!(id: params[:id])
    @order.owner = current_account

    if @order.cancel && @order.save
      redirect_to :root
    else
      redirect_to order_path(@order)
    end
  end

  def respond
    @order = Order.find_by!(id: params[:id])
    @response = current_account.responses.create({order: @order}.merge(response_attributes))

    if @response.save && @order.save
      OrdersMailer.responded(current_account, @order, @response).deliver

      redirect_to :root
    else
      redirect_to order_path(@order)
    end
  end

  private def orders_attributes
    params.require(:order).permit(:description, :priority, :subtype)
  end

  private def response_attributes
    params.require(:response).permit(:message)
  end
end
