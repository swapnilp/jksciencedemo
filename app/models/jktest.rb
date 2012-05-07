class Jktest < ActiveRecord::Base
  attr_accessible :name, :subject_id, :teacher_id, :chapters_id, :no_of_questions, :user_id


  #association
  has_many :testquestions
  has_many :batchtest
  has_many :batchs, :through => :batchtest
  belongs_to :subject
  belongs_to :user
  
  #validations
  validates_associated :batchtest
  #validates_associated :batchs
  validates_associated :testquestions
  validates :name, :presence => true, :uniqueness => true
  validates :subject_id, :presence => true
  validates :user_id, :presence => true
  validates :no_of_questions, :presence => true, :format => { :with => /\A[0-9]*\z/,
    :message => "only digits allowed"}

  #callback
  before_validation :validate_subject, :validate_user
  
  #function validates subject is exist or not in subject table
  def validate_subject
    errors.add(:subject_id, 'not presence') if Subject.find_by_id( self[:subject_id] ) == nil
  end
  
  #function validates user is exist or not in user table
   def validate_user
    errors.add(:user_id, 'not presence') if User.find_by_id( self[:user_id] ) == nil
  end
end
