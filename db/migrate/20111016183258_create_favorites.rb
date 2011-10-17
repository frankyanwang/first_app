class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.integer :user_id
      t.integer :post_id

      t.timestamps
    end
    
    add_index "favorites", :user_id, :name => "index_favorites_on_user_id"
    add_index "favorites", :post_id, :name => "index_favorites_on_post_id"
    
  end
end
