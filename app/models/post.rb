class Post < ActiveRecord::Base
  belongs_to :user
  has_many :post_images
  
  has_many :proposals
  has_many :trade_posts, :through => :proposals
  
  has_many :inverse_proposals, :class_name => "Proposal", :foreign_key => "trade_post_id"
  has_many :origin_posts, :through => :inverse_proposals, :source => :post

  has_many :likeships
  # only need this association when we query all users like one post directly e.g post.likers.
  has_many :likers, :through => :likeships, :source => :user
  
  has_many :comments
  #TODO optional
  has_many :commentors, :through => :comments, :source => :user
  
  has_many :favorites
  #TODO optional
  has_many :favorited_users, :through => :favorites, :source => :user
  

  attr_accessible :name, :content, :trade, :cash, :user_id, :status_type
  
  attr_accessor :status_type
  
  validates :name, :content, :trade, :presence => true
  
  STATUS = { :available => 0, :proposed => 1, :traded => 2 }
  
  before_create :update_status
  
  def update_status
    self.status_type = :available
  end
  
  def status_type
    status_type = STATUS.key(status)
  end
  
  def status_type=(value)
    self.status = STATUS[value]
  end  
  
end
