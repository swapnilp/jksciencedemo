class ReportsController < ApplicationController
  def index
    @batches = Batch.all
    @students = Student.all
    @jktests = Jktest.all
    @marks = Mark.all
  end

  
  def show
  end

  
end
