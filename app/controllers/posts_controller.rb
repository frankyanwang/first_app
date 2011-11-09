class PostsController < ApplicationController
  before_filter :authenticate_user!
  
  respond_to :html, :json, :xml
  #TODO only admin access
  def index
    @posts = Post.all
  end
  
  # GET /my_posts
  # GET /my_posts.json  
  def my_posts
    @posts = current_user.posts
    # @post_wanted_id = params[:post_id]
    #respond_to do |format|
      # format.html { render "my_posts"}
     # format.html { render :partial => "my_posts"}
      #format.json { render :json => @posts }
    #end    
    # render :json => @posts
  end
    
  def feed_posts_timeline
    user_follower = current_user.followers
    user_followers_include_current_user_array = user_follower.collect {|f| f.id} << current_user.id
        
    @feed_posts = Post.includes(:post_images, :favorites) #eager load to reduce N+1 queries.
                      .where(:user_id => user_followers_include_current_user_array) #all following user and current user.
                      .order("created_at DESC") # order by creation time.
                      .limit(params["limit"] ? params["limit"].to_i : 2) #default 20
                      .offset(params["offset"] ? params["offset"].to_i : 0) #default 0 offset, meaning get latest.
    
   # render :feed_posts_timeline, :layout => params[:layout] == "false" ? false : true
    # render :xml => @feed_posts
  end

  def show
    #@post = current_user.posts.find(params[:id])
    @post = Post.find(params[:id])
    @images = @post.post_images
    #TODO eager loading?
    @comments = @post.comments
    @likers = @post.likers
    @favorites = @post.favorited_users
    
    @is_post_favorited = current_user.favorites.where(:post_id => @post).first
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(params[:post])
    Post.transaction do
      if @post.save
        attach_image @post, params[:post][:image]
        redirect_to @post, :notice => "Successfully created post."
      else
        render :action => 'new'
      end
    end
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update_attributes(params[:post])
      reattach_image @post, params[:post][:image]
      redirect_to @post, :notice  => "Successfully updated post."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    redirect_to posts_url, :notice => "Successfully destroyed post."
  end
  
  protected
  
  #TODO support multi image upload. Not sure how we want to support yet.
  # def attach_images(post, image_form)
  #   # if(image_form)
  #   #   @images = post.post_images.build(:image => image_form)
  #   #   @images.save
  #   # end
  #   
  # end
  # 
  # def reattach_images(post, image_form)
  #   # if(image_form)
  #   #   PostImage.destroy post.post_images.collect(&:id)
  #   #   attach_image post, image_form
  #   # end
  # end
    
  def attach_image(post, image_form)
    if(image_form)
      @image = post.post_images.build(:image => image_form)
      @image.save
    end
  end
  
  def reattach_image(post, image_form)
    if(image_form)
      PostImage.destroy post.post_images.collect(&:id)
      attach_image post, image_form
    end
  end
end
