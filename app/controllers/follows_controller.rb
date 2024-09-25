class FollowsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:user_id])
    @follow = current_user.follows.build(followed_id: @user.id)

    if @follow.save
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @follow = current_user.follows.find_by(followed_id: @user.id)

    if @follow
      @follow.destroy
      flash[:notice] = "You have unfollowed this user."
    else
      redirect_to root_path
    end
  end
end
