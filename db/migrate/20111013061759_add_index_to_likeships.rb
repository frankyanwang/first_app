class AddIndexToLikeships < ActiveRecord::Migration
  def change
      add_index "likeships", ["post_id", "user_id"], :name => "index_like_on_post_id_user_id", :unique => true      
  end
end
