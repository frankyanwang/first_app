class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :name
      t.string :content
      t.string :trade
      t.integer :cash
      t.integer :user_id
      t.integer :status
      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
