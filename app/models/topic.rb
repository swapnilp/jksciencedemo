class Topic < ActiveRecord::Base
  attr_accessible :name, :chapter_id, :priority, :user_id
  
  #association
  belongs_to :chapter
  belongs_to :user
  has_many :questions
  has_many :forums

  #validation
  validates :user_id, :presence => true
  validates :name, :presence => true
  validates :priority, :format => { :with => /\A[1-5]+\Z/, 
  :message => "only in between 1 to 5"}
  validates :chapter_id, :presence => true
  validates_associated :questions
  validates_associated :forums
  
  before_validation :validate_chapter, :validate_user

  def validate_chapter
    errors.add(:chapter_id, 'Chapter not presence') if Chapter.find_by_id( self[:chapter_id] ) == nil
  end

  #function validates user is exist or not in user table
  def validate_user
    errors.add(:user_id, 'not presence') if User.find_by_id( self[:user_id] ) == nil
  end

  
end
