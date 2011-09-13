class CreatePostImages < ActiveRecord::Migration
  def self.up
    create_table :post_images do |t|
      t.string :image
      t.integer :post_id
      t.timestamps
    end
  end

  def self.down
    drop_table :post_images
  end
end
