class UserStocksController < ApplicationController

  def create
    stock = Stock.check_db(params[:ticker])

    if stock.blank?
      stock = Stock.new_lookup(params[:ticker])
      stock.save
    end

    UserStock.create(user: current_user, stock: stock)
    flash[:notice] = "#{stock.name} (#{stock.ticker}) was added to your portfolio"
    redirect_to my_portfolio_path
  end

  def destroy
    stock = Stock.find params[:id]

    UserStock.where(user_id: current_user.id, stock_id: stock.id).first.destroy
    flash[:notice] = "#{stock.name} (#{stock.ticker}) was removed from your portfolio"
    redirect_to my_portfolio_path
  end
end
