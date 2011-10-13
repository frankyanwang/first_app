class CreateLikeships < ActiveRecord::Migration
  def change
    create_table :likeships do |t|
      t.integer :user_id
      t.integer :post_id

      t.timestamps
    end
  end
end
