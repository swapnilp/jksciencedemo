class Forum < ActiveRecord::Base
  attr_accessible :description, :title, :topic_id, :user_id
  
  #association
  belongs_to :topic
  belongs_to :user
  has_many :posts
  
  #validation
  validates :topic_id, :presence => true
  validates :user_id, :presence => true
  validates :title, :presence => true, :uniqueness => true
  validates :description, :presence => true
  validates_associated :posts

  #callback
  before_validation :validate_user, :validate_topic

  # validate_user is a function it's generete the error if User is not present in user table
  def validate_user 
    errors.add(:user_id, 'user not presence') if User.find_by_id( self[:user_id] ) == nil
  end

  # validate_topic is a function it's generate the error if chapter topic in not present in the topic table
  def validate_topic
    errors.add(:topic_id, 'Topic not presence') if Topic.find_by_id( self[:topic_id] ) == nil
  end
end
