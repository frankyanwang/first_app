class UsersController < AuthorizedController
  #before_filter :authenticate_user!

  #add pagination, it could be expensive to query for user with following condition.
  def index
    #all of the users except current user.
    @users = User.where(["id != ?", current_user.id])

    #solution 1: do all that to reduce the N+1 queries in DB. @users could be just one page of users to further filter down.
    followships = current_user.followships.where(:follower_id => @users).select("id, follower_id")    
    #construct a hash which map follower_id => followship_id
    hash_follower_to_followship_id = Hash[ *followships.collect {|f| [f.follower_id, f.id]}.flatten ]
    for user in @users
      user.being_followed_user_associate_followship_id = hash_follower_to_followship_id[user.id]
    end
    
    #solution 1: Completed 200 OK in 227ms (Views: 162.1ms | ActiveRecord: 11.0ms)
    #solution 2: Completed 200 OK in 314ms (Views: 231.1ms | ActiveRecord: 26.9ms)
    
    #solution 2: traditional way, which make more sense.  
    # followships = current_user.followships
    # for user in @users
    #   user.being_followed_user_associate_followship_id = followships.where(["follower_id = ?", user.id])[0]
    # end    

  end

  def show
    @user = User.find(params[:id])
    @is_current_user = @user == current_user
  end
  
end
