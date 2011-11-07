class LikeshipsController < ApplicationController
  before_filter :authenticate_user!
  
  respond_to :html, :json, :xml
  
  def create
    @likeship = current_user.likeships.build(:post_id => params[:post_id])
    if @likeship.save
      flash[:notice] = "You start like '#{@likeship.post.name}'."
      #temporary redirect to itself. Need to make it an ajax or REST API call.
      redirect_to request.referer
    else
      flash[:error] = "unable to like."
      redirect_to root_url
    end
  end

  def destroy
    @likeship = current_user.likeships.find(params[:id])
    @likeship.destroy
    redirect_to request.referer, :notice => "You stop like '#{@likeship.post.name}' anymore."
  end
  
  def index
    post = Post.find(params[:post_id])
    @likers = post.likers
  end

end
