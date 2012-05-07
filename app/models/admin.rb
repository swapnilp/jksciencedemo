class Admin < ActiveRecord::Base
  attr_accessible :name, :phone_number, :email
  

  #validation
  validates :name, :presence => true
  validates :phone_number, :presence => true, :format => { :with => /\A[0-9]{10,14}\Z/,
  :message => 'only 10 to 12 digits allowed'}, :uniqueness => true
  validates :email, :presence => true, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
    :message => "Email not valide" }, :uniqueness => true
  #callback

  before_validation :validate_email
  before_destroy :delete_user

  def validate_email
    errors.add(:email, 'all ready exist') if !(Student.find_by_email(self[:email]).nil? and  Teacher.find_by_email(self[:email]).nil?)
  end
  
  def delete_user
    if !User.joins(:role).where(:roles => {:name => 'Admin'}, :users => { :employee_id => self[:id]}).nil?
      User.find_by_email(self[:email]).destroy
    end
  end
  
end
