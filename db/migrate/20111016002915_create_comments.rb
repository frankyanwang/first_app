class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :description
      t.integer :user_id
      t.integer :post_id

      t.timestamps
    end
    
    add_index "comments", :post_id, :name => "index_comments_on_post_id"      
  end
end
