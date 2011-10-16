class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  
  # only allow to mass assignment for these two attributes.
  attr_accessible :description, :post_id
end
