class Likeship < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  
  attr_accessible :user_id, :post_id
  
  validates :post_id, :uniqueness => {:scope => :user_id, :message => "should only like once."}
  
end
