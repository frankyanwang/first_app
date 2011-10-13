class LikeshipsController < ApplicationController
  before_filter :authenticate_user!
  
  def create
    @likeship = current_user.likeships.build(:post_id => params[:post_id])
    if @likeship.save
      flash[:notice] = "You start like '#{@likeship.post.name}'."
      redirect_to root_url
    else
      flash[:error] = "unable to like."
      redirect_to root_url
    end
  end

  def destroy
    @likeship = current_user.likeships.find(params[:id])
    @likeship.destroy
    redirect_to root_url, :notice => "You stop like '#{@likeship.post.name}' anymore."
  end
end
