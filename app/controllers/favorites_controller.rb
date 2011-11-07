class FavoritesController < ApplicationController
  before_filter :authenticate_user!
  
  respond_to :html, :json, :xml
  
  def create
    @favorite = current_user.favorites.build(:post_id => params[:post_id])
    if @favorite.save
      flash[:notice] = "You have marked '#{@favorite.post.name}' your favorite."
      #temporary redirect to itself. Need to make it an ajax or REST API call.
      redirect_to request.referer
    else
      flash[:error] = "unable to favorite."
      redirect_to root_url
    end
  end

  def destroy
    @favorite = current_user.favorites.find(params[:id])
    @favorite.destroy
    redirect_to request.referer, :notice => "You have unmarked '#{@favorite.post.name}' your favorite."
  end
  
  def my_favorites
    @my_posts = current_user.favorited_posts.order("favorites.created_at DESC")
  end
  
  def index
    post = Post.find(params[:post_id])    
    @favorites = post.favorited_users
  end

end
