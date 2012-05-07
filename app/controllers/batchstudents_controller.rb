class BatchstudentsController < ApplicationController
  load_resource
  def index
    respond_to do |format|
      @batchstudents = Batchstudent.find(:all, :conditions => {:batch_id => params[:batch_id]})
      @batch_id = params[:batch_id]
      format.js
    end
  end

  def new
    respond_to do |format|
      @batch_id = params[:batch_id]
      @students = Student.find(:all, :conditions => {:group => Batch.find(params[:batch_id]).group  })
      # @students = Student.all
      format.js
    end
  end
  
  def edit
    respond_to do |format|
      @batch_id = params[:batch_id]
      @batchstudent = Batchstudent.find(params[:id])
      format.js
    end
  end

  def update
    @batchstudent = Batchstudent.find(params[:id])
    respond_to do |format|
      if @batchstudent.update_attributes(params[:batchstudent])
        format.js { redirect_to :action => 'index', :batch_id => params[:batch_id] }
      end
    end
  end
  
  def destroy
    respond_to do |format|
      if Batchstudent.find(params[:id]).destroy
        format.js { redirect_to :action => 'index', :batch_id => params[:batch_id] }
      end
    end
  end
  
  def add_batch_student
    respond_to do |format|
      @batch_id = params[:batch_id]
      params[:students].each do |id|
        Batchstudent.new(:batch_id => @batch_id, :student_id => id.to_i, :report => 'not seen').save
      end
      format.js { redirect_to :action => 'index', :batch_id => @batch_id }
    end
  end
  
end
