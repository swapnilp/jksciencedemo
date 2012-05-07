class Teacher < ActiveRecord::Base
  attr_accessible :name, :phone_number, :address, :subject_id, :email

  #Association
  belongs_to :subject
  
  #validation
  validates :name, :presence => true, :uniqueness => true
  validates :phone_number, :presence => true, :uniqueness => true , :format => { :with => /\A[0-9]{10,12}*\z/,
    :message => "Only 10 to 12 number valide" }
  validates :address, :presence => true
  validates :subject_id, :presence => true
  validates :email, :presence => true, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
    :message => "not valide" }, :uniqueness => true

  #callback
  before_validation :validate_subject, :validate_email
  
  def validate_subject
    errors.add(:subject_id, 'Subject not presence') if Subject.find_by_id( self[:subject_id] ) == nil
  end

  def validate_email
    errors.add(:email, 'all ready exist') if !(Student.find_by_email(self[:email]).nil? and  Admin.find_by_email(self[:email]).nil?)
  end
end
