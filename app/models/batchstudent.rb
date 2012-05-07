class Batchstudent < ActiveRecord::Base
  attr_accessible :batch_id, :student_id,:report
  
  #association
  belongs_to :batch
  belongs_to :student
  
  #validation
  validates :batch_id, :presence => true
  validates :report, :presence => true
  validates :student_id, :presence => true, :uniqueness => { :scope => :batch_id,
    :message => "should happen once per batch" }
  
  #callback
   before_validation :validate_batch_student

  def validate_batch_student
    errors.add(:batch_id, 'not presence') if Batch.find_by_id( self[:batch_id] ) == nil
    errors.add(:student_id, 'not presence') if Student.find_by_id( self[:student_id] ) == nil
  end
end
