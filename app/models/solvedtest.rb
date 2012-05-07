class Solvedtest < ActiveRecord::Base
  attr_accessible :batchtest_id, :student_id, :questions_id, :questions_answer

  #association
#  belongs_to :batchtest
#  belongs_to :student

  #validation
#  validates :batchtest_id, :presence => true
#  validates :student_id, :presence => true
#  validates :test_questions_id, :presence => true
#  validates :test_answers_id, :presence => true
#  validates :ip_id, :presence => true

  #callback
#  before_validation :validate_batchtest, :validate_student

  def validate_jktest
    errors.add(:batchtest_id, 'Batch\'s Test not presence') if Batchtest.find_by_id( self[:batchtest_id] ) == nil
  end

  def validate_student
    errors.add(:student_id, 'Student not presence') if Student.find_by_id( self[:student_id] ) == nil
  end
end
