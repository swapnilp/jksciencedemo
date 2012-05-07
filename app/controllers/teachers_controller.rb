class TeachersController < ApplicationController
  load_resource
  def index
    @teachers = Teacher.all
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def show
    @teacher = Teacher.find(params[:id])
  end

  def new
    @subjects = Subject.all
    respond_to do |format|
      @teacher = Teacher.new
      format.js # required or the controller will not respond to AJAX calls
    end
  end
  
  def create
    role_id = Role.where("name='teacher'")[0][:id]
    @teacher = Teacher.new(params[:teacher])
    respond_to do |format|
      if @teacher.save
        if User.new(:employee_id => @teacher.id, :password =>'jkscience123', :password_confirmation => 'jkscience123', :role_id => role_id , :email => @teacher.email ).save
          format.js { redirect_to :action => 'index' }
        end
      else
        @subjects = Subject.all
        format.js { render :action => 'new' }
      end
    end
  end
  
  def edit
    @teacher = Teacher.find(params[:id])
    respond_to do |format|
      # format.html
      format.js  # required or the controller will not respond to AJAX calls
    end
  end

  def update
    @teacher = Teacher.find(params[:id])
    respond_to do |format|
      if @teacher.update_attributes(params[:teacher])
        format.html { redirect_to @teacher, notice: 'Teacher was successfully updated.' }
        format.js {redirect_to :action => 'show'}
      else
        format.js { render :action => 'edit' }
      end
    end
  end
  
  def destroy
    #Student.find(params[:id]).destroy
    #redirect_to :action => 'index'
    respond_to do |format|
      if Teacher.find(params[:id]).destroy
        format.js { redirect_to :action => 'index' }
      end
    end
  end

end
