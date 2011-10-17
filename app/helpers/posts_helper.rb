module PostsHelper
  def get_my_favorite_post post
    post.favorites.where(:user_id => current_user.id).first
  end
end
