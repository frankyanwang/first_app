class User < ActiveRecord::Base
  
  has_many :followships
  has_many :followers, :through => :followships
  
  has_many :inverse_followships, :class_name => "Followship", :foreign_key => "follower_id"
  has_many :followings, :through => :inverse_followships, :source => :user
  
  has_many :posts
  has_many :proposals
  
  ROLE_TYPE = { 1 => :admin, 0 => :regular }
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  validates_uniqueness_of :username         

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :phone, :password, :password_confirmation, :remember_me, :login
  attr_accessible :avatar, :remote_avatar_url
  
  mount_uploader :avatar, AvatarUploader
  # warn: dont want to set accessible for attr_accessible :role
  
  attr_accessor :login
  
  def is_role? role
    User::ROLE_TYPE[self.role] == role.to_sym.downcase
  end
  
  # Used for storing followship to identify if user is "follow" already or not by current user. Then "unfollow". 
  attr_accessor :is_being_followed

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
