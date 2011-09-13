class PostsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @posts = Post.all
  end

  def show
    @post = current_user.posts.find(params[:id])
    @images = @post.post_images
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
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      reattach_image @post, params[:post][:image]
      redirect_to @post, :notice  => "Successfully updated post."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_url, :notice => "Successfully destroyed post."
  end
  
  protected
  
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