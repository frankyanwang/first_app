class Post < ActiveRecord::Base
  belongs_to :user
  has_many :post_images
  attr_accessible :name, :content, :trade, :cash, :user_id, :status
end
