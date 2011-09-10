class FollowshipsController < ApplicationController
  before_filter :authenticate_user!
  
  def create
    @followship = current_user.followships.build(:follower_id => params[:follower_id])
    if @followship.save
      flash[:notice] = "You start following '#{@followship.follower.username}'."
      redirect_to root_url
    else
      flash[:error] = "unable to follow."
      redirect_to root_url
    end
  end

  def destroy
    @followship = current_user.followships.find(params[:id])
    @followship.destroy
    redirect_to root_url, :notice => "You stop following '#{@followship.follower.username}' anymore."
  end
end
