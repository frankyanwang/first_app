class Proposal < ActiveRecord::Base
  belongs_to :post
  belongs_to :trade_post, :class_name => "Post"
  belongs_to :user
  
  attr_accessible :post_id, :trade_post_id, :user_id, :propose, :status_type, :price
  
  attr_accessor :status_type
  
  #validates :propose, :presence => true
  validates :price, :numericality => true, :allow_nil => true

  #TODO validate numerical might not needed. post_id could be a hash code for security.
  # validates :post_id, :trade_post_id, :numericality => true
  validate :validate_post_item_and_trade_post_item
  
  validates :post_id, :uniqueness => {:scope => :trade_post_id, :message => "You have been proposed already."}
  
  STATUS = { :pending => 0, :accept => 1, :reject => 2, :counter => 3, :expire =>4 }
    
  def status_type
    status_type = STATUS.key(status)
  end
  
  def status_type=(value)
    self.status = STATUS[value]
  end 
  
  protected
  
  def validate_post_item_and_trade_post_item
    #no need to validate further.
    if errors.size > 0
      return
    end
    post = Post.where(:id => self.post_id).first  
    if post.nil?
      errors[:base] << "Proposal failed: Post #{self.post_id} cannot be found."
    elsif Post::STATUS.key(post.status) != :available
      errors[:base] << "Proposal failed: Post #{self.post_id} is not available anymore."
    elsif post.user.id == self.user_id  
      errors[:base] << "Proposal failed: You cannot propose your own post #{self.post_id}."
    end
  
    trade_post = Post.where(:id => self.trade_post_id, :user_id => self.user_id).first
    if trade_post.nil?
      #use error:base because post_id is not a form field.
      errors[:base] << "Proposal failed: Trade post #{self.trade_post_id} cannot be found."
    end
    
  end
  
end
