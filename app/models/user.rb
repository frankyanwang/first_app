class User < ActiveRecord::Base
  
  has_many :followships
  has_many :followers, :through => :followships
  
  has_many :inverse_followships, :class_name => "Followship", :foreign_key => "follower_id"
  has_many :followings, :through => :inverse_followships, :source => :user
  
  has_many :posts
  has_many :proposals

  #TODO this might not needed. we don't see facebook list all of your liked posts. just way too many and not that valuable.
  #but we can do this kind of relationship for favorite/bookmarks 
  has_many :likeships
  has_many :liked_posts, :through => :likeships, :source => :post

  has_many :comments
  
  has_many :favorites
  has_many :favorited_posts, :through => :favorites, :source => :post
  
  before_save :downcase_login
  after_create :update_authentication_token
  
  has_many :authentications
    
  ROLE_TYPE = { 1 => :admin, 0 => :regular }
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable
         
  validates_uniqueness_of :username, :case_sensitive => false
  validates_uniqueness_of :email, :case_sensitive => false         

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :phone, :password, :password_confirmation, :remember_me, :login, :id
  attr_accessible :avatar, :remote_avatar_url
  
  mount_uploader :avatar, AvatarUploader
  # warn: dont want to set accessible for attr_accessible :role
  
  attr_accessor :login
  
  def downcase_login
    self.email.downcase!
    self.username.downcase!
  end
  
  # after create user object, update auth_token for this user.
  def update_authentication_token
    if !self.authentication_token
      logger.info "auth_token: #{self.authentication_token}"
      self.reset_authentication_token!
      logger.info "auth_token: #{self.authentication_token}"
    end
  end
  
  def is_role? role
    User::ROLE_TYPE[self.role] == role.to_sym.downcase
  end
  
  # Used for storing followship to identify if user is "follow" already or not by current user. Then "unfollow". 
  # nil means this user is not following.
  attr_accessor :being_followed_user_associate_followship_id

  def apply_omniauth(omniauth)
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end
  
  def password_required?
    (authentications.empty? || !password.blank?) && super
  end
  
  protected
  
  #override for login.
  #https://github.com/plataformatec/devise/wiki/How-To:-Allow-users-to-sign_in-using-their-username-or-email-address
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
  end
  
  # Attempt to find a user by it's email. If a record is found, send new
  # password instructions to it. If not user is found, returns a new user
  # with an email not found error.
  def self.send_reset_password_instructions(attributes={})
    recoverable = find_recoverable_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
    recoverable.send_reset_password_instructions if recoverable.persisted?
    recoverable
  end 

  def self.find_recoverable_or_initialize_with_errors(required_attributes, attributes, error=:invalid)
    (case_insensitive_keys || []).each { |k| attributes[k].try(:downcase!) }

    attributes = attributes.slice(*required_attributes)
    attributes.delete_if { |key, value| value.blank? }

    if attributes.size == required_attributes.size
      if attributes.has_key?(:login)
         login = attributes.delete(:login)
         record = find_record(login)
      else  
        record = where(attributes).first
      end  
    end  

    unless record
      record = new

      required_attributes.each do |key|
        value = attributes[key]
        record.send("#{key}=", value)
        record.errors.add(key, value.present? ? error : :blank)
      end  
    end  
    record
  end

  def self.find_record(login)
    where(["username = :value OR email = :value", { :value => login }]).first
  end   
  
end
