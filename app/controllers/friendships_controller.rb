class FriendshipsController < ApplicationController
  def create
    user = User.find(params[:user])
    current_user.friends << user

    flash[:notice] = "You followed #{user.first_name}"
    redirect_to my_friends_path
  end

  def destroy
    friend_id = params[:id]

    user_first_name = User.find(friend_id).first_name
    friendship = current_user.friendships.where(friend_id: friend_id).first
    friendship.destroy

    flash[:notice] = "You stopped following #{user_first_name}"
    redirect_to my_friends_path
  end
end
