class Testattempt < ActiveRecord::Base
    attr_accessible :batchtest_id, :student_id

  #association                                                                                                                                                                                       
  belongs_to :student
  belongs_to :batchtest

  #validates                                                                                                                                                                                         
  validate :student_id, :presence => true
  validates :batchtest_id, :presence => true

  #callbacks                                                                                                                                                                                         
  before_validation :validate_batchtest, :validate_student

  def validate_batchtest
    errors.add(:batchtest_id, 'Batch\'s Test not presence') if Batchtest.find_by_id( self[:batchtest_id] ) == nil
  end

  def validate_student
    errors.add(:student_id, 'Student not presence') if Student.find_by_id( self[:student_id] ) == nil
  end
end
