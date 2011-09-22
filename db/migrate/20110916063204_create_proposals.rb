class CreateProposals < ActiveRecord::Migration
  def self.up
    create_table :proposals do |t|
      t.integer :post_id
      t.integer :trade_post_id
      t.integer :user_id
      t.string :propose
      t.integer :status
      t.decimal :price, :precision => 8, :scale => 2
      t.timestamps
    end
    add_index "proposals", ["post_id", "trade_post_id"], :name => "index_proposal_on_post_id_trade_post_id", :unique => true      
  end

  def self.down
    drop_table :proposals
  end
end
