class Likeship < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  
  attr_accessible :user_id, :post_id
end
