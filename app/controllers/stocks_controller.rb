class StocksController < ApplicationController
  def search
    symbol = params[:stock]

    if symbol.present?
      @stock = Stock.new_lookup symbol
      if @stock
        render "users/my_portfolio"
      else
        flash[:alert] = "Unknown stock symbol: #{symbol}"
        redirect_to my_portfolio_path
      end
    else
      flash[:alert] = 'Please enter a symbol to search'
      redirect_to my_portfolio_path
    end
  end
end
