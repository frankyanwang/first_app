class Followship < ActiveRecord::Base
  belongs_to :user
  belongs_to :follower, :class_name => "User"
  
  attr_accessible :user_id, :follower_id
end
