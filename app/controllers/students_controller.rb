class StudentsController < ApplicationController
#  authorize_resource
#  load_resource
#  rescue_from CanCan::AccessDenied do |exception|
#    redirect_to root_url, :alert => exception.message
#  end
  def index
    @students = Student.all
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def show
    @student = Student.find(params[:id])
  end

  def new
    respond_to do |format|
      @student = Student.new
      format.js # required or the controller will not respond to AJAX calls
    end
  end
  
  def create
    @student = Student.new(params[:student])
    respond_to do |format|
      if @student.save
        format.js { redirect_to :action => 'index' }
      else
        format.js { render :action => 'new' }
      end
    end
  end
  
  def edit
    @student = Student.find(params[:id])
    respond_to do |format|
      # format.html
      format.js  # required or the controller will not respond to AJAX calls
    end
  end

  def update
    @student = Student.find(params[:id])
    respond_to do |format|
      if @student.update_attributes(params[:student])
        format.html { redirect_to @student, notice: 'Post was successfully updated.' }
        format.js {redirect_to :action => 'show'}
      else
        format.js { render action: "edit" }
      end
    end
  end
  
  def destroy
    #Student.find(params[:id]).destroy
    #redirect_to :action => 'index'
    respond_to do |format|
      if Student.find(params[:id]).destroy
        format.js { redirect_to :action => 'index' }
      end
    end
  end
end
