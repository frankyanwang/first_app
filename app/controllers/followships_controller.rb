class FollowshipsController < ApplicationController
  def create
    @followship = current_user.followships.build(:follower_id => params[:follower_id])
    if @followship.save
      flash[:notice] = "You are following " + current_user.followers.find(params[:follower_id]).username
      redirect_to root_url
    else
      flash[:error] = "unable to follow."
      redirect_to root_url
    end
  end

  def destroy
    @followship = current_user.followships.find(params[:id])
    @followship.destroy
    redirect_to root_url, :notice => "Not follwing anymore."
  end
end
