class Testquestion < ActiveRecord::Base
  attr_accessible :question_id, :jktest_id, :user_id
  
  #association
  belongs_to :question
  belongs_to :jktest
  belongs_to :user
  
  #validation
  validates :user_id, :presence => true
  validates :question_id, :presence => true, :uniqueness => { :scope => :jktest_id,
    :message => "should happen once per Test" }
  validates :jktest_id, :presence => true
  
  #callback
  before_validation :validate_question, :validate_jktest, :validate_user

  def validate_question
    errors.add(:question_id, 'not presence') if Question.find_by_id( self[:question_id] ) == nil
  end
  
  def validate_jktest
    errors.add(:jktest_id, 'Test not presence') if Jktest.find_by_id( self[:jktest_id] ) == nil
  end
  
  def validate_user
    errors.add(:user_id, 'not presence') if User.find_by_id( self[:user_id] ) == nil
  end
end
