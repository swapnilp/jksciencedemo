class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  #  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :email, :password, :password_confirmation, :remember_me, :current_sign_in_ip, :role_id, :employee_id, :reset_password_token

  #Record Associations 
  has_many :subjects
  has_many :topics
  has_many :forums
  has_many :posts
  has_many :jktests
  has_many :testquestions
  has_many :solvedtests
  has_many :questions
  belongs_to :role

  #validation
  validates_associated :testquestions
  validates_associated :forums
  validates_associated :posts
  validates_associated :jktests
  validates_associated :solvedtests
  validates_associated :questions
  validates :email, :uniqueness => true, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
    :message => "Email not valide" }

  validates :employee_id, :presence => true
  #validates :role_id, :presence => true

  before_validation :validate_role
  before_destroy :delete_posts 
  
  def validate_role
    errors.add(:role_id, 'Role not presence') if Role.find_by_id( self[:role_id] ) == nil
  end
  
  def delete_posts
    Post.where("user_id = ? ",self[:id]).delete_all
  end
end
