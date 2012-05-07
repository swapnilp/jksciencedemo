class Batch < ActiveRecord::Base
  require 'date'
  attr_accessible :description, :start_date, :end_date, :group, :incharge
  
  #association
  has_many :batchtest
  has_many :jktests, :through => :batchtest
  has_many :batchstudents
  
  #validation
  validates_associated :jktests
  validates_associated :batchtest
  validates_associated :batchstudents
  validates :description, :presence => true, :uniqueness => true
  validates :start_date, :presence => true
  validates :end_date, :presence => true
  validates :group, :presence => true, :inclusion => { :in => %w(pcb pcm pcmb),
    :message => "not valid group" }
  validates :incharge, :presence => true
  
  #callback
  before_validation :validate_date  

  #validate dates 
  def validate_date
    errors.add(:start_date, 'not valide') if self[:start_date] < Date.today
    errors.add(:end_date, 'must greater than start date') if self[:start_date] >= self[:end_date]
  end

end
