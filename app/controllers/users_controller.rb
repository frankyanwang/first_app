class UsersController < AuthorizedController
  #before_filter :authenticate_user!

  #add pagination, it could be expensive to query for user with following condition.
  def index
    #all of the users except current user.
    @users = User.where(["id != ?", current_user.id]).all
    #all users that current user are following.
    #following_users = current_user.followers
    followships = current_user.followships
    for user in @users
      user.is_being_followed = followships.where(["follower_id = ?", user.id])[0] #get empty array or one element array.
    end
  end

  def show
    @user = User.find(params[:id])
    @is_current_user = @user == current_user
  end
  
end
