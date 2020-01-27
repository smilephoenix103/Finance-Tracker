class UsersController < ApplicationController
  def edit
  end

  def my_portfolio
    @tracked_stocks = current_user.stocks
  end

  def my_friends
    @friends = current_user.friends
  end

  def search
    friend = params[:friend]

    if friend.present?
      @users = User.search(friend)
      @users = current_user.filter_current_user(@users)

      if @users
        respond_to do |format|
          format.js { render partial: 'users/friends_result'}
        end
      else
        respond_to do |format|
          flash.now[:alert] = "No users found with that name or email address"
          format.js { render partial: 'users/friends_result' }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = 'Please enter a name or email address to search'
        format.js { render partial: 'users/friends_result' }
      end
    end
  end

end
