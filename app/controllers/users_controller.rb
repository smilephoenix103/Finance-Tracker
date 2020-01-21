class UsersController < ApplicationController
  def edit

  end

  def my_portfolio
    @tracked_stocks = current_user.stocks
  end
end
