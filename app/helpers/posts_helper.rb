module PostsHelper
  def get_my_favorite_post post
    if current_user
      post.favorites.where(:user_id => current_user.id).first
    else
      post.favorites.first
    end
  end
end
