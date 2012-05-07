class Chapter < ActiveRecord::Base
  attr_accessible :name, :subject_id, :chapter_number

  #validation
  belongs_to :subject
  has_many :topics
  
  #association
  validates :subject_id, :presence => true
  validates :chapter_number, :presence => true, :numericality => { :only_integer => true }, :uniqueness => { :scope => :subject_id,
    :message => "should happen once per subject" }
  validates :name, :presence => true, :uniqueness => true
  validates_associated :topics
  
  before_validation :validate_subject
  
  def validate_subject
    errors.add(:subject_id, 'not presence') if Subject.find_by_id( self[:subject_id] ) == nil
  end

  #function validates user is exist or not in user table 


end
