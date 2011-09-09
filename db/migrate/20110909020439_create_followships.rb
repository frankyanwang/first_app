class CreateFollowships < ActiveRecord::Migration
  def self.up
    create_table :followships do |t|
      t.integer :user_id
      t.integer :follower_id
      t.timestamps      
    end
    
    add_index "followships", ["user_id", "follower_id"], :name => "index_followers_on_user_id_and_follower_id", :unique => true      
  end

  def self.down
    drop_table :followships
  end
end
