class Role < ActiveRecord::Base  
  attr_accessible :name

  #association
  has_many :users,  :dependent => :destroy  
  

  #validation
  validates_associated :users
  validates :name, :presence => true, :uniqueness => true

end
