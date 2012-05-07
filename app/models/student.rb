class Student < ActiveRecord::Base
  attr_accessible :name, :phone_number, :address, :email, :parent_contact, :group,:standerd, :ssc_marks

  #association

  has_many :batchstudents
  has_many :marks
  has_many :testattempts
  
  #validations  
  validates_associated :batchstudents
  validates_associated :marks
  validates_associated :testattempts
  validates :name, :presence => true
  validates :phone_number, :presence => true, :format => { :with => /\A[0-9]{10,12}*\z/,
    :message => "Only 10 to 12 number valide" }
  validates :address, :presence => true
  validates :group, :presence => true, :inclusion => { :in => %w(pcb pcm pcmb),
    :message => "%{value} is not a valid size" }
  validates :email, :presence => true, :uniqueness => true, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,    
    :message => "Email not valide" } 
  validates :standerd, :presence => true, :format => { :with => /\A(11|12){1}\Z/,
  :message => "not valide"}
  validates :ssc_marks, :presence => true
  validates :parent_contact, :presence => true, :format => { :with => /\A[0-9]{10,12}\z/,
    :message => "Only  10 to 12 numbers allowed" }

  
  #callback
  before_validation :validate_email
  before_destroy :delete_user
  
  def validate_email
    errors.add(:email, 'all ready exist') if !(Teacher.find_by_email(self[:email]).nil? and  Admin.find_by_email(self[:email]).nil?)
  end
  
  def delete_user
    if !User.joins(:role).where(:roles => {:name => 'student'}, :users => { :employee_id => self[:id]}).nil?
      User.find_by_email(self[:email]).destroy
    end
  end

end
