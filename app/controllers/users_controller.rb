class UsersController < ApplicationController
  before_filter :authenticate_user!
  
  #add pagination, it could be expensive to query for user with following condition.
  def index
    #all of the users except current user.
    @users = User.where(["id != ?", current_user]).all
    #all users that current user are following.
    #following_users = current_user.followers
    followships = current_user.followships
    for user in @users
      user.is_being_followed = followships.where(["follower_id = ?", user.id])[0] #get empty array or one element array.
    end
  end

  def show
    @user = User.find(params[:id])
  end
  
  def profile
    @user = current_user
    render :show
  end  

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to @user, :notice => "Successfully created user."
    else
      render :action => 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to @user, :notice  => "Successfully updated user."
    else
      render :action => 'edit'
    end
  end

  # def destroy
  #   @user = User.find(params[:id])
  #   @user.destroy
  #   redirect_to users_url, :notice => "Successfully destroyed user."
  # end
end
