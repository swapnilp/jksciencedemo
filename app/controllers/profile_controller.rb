class ProfileController < ApplicationController
  def show
    respond_to do |format|
      if current_user.role.name == "student"
        @student = Student.find(current_user.employee_id)
        @batchs = Batch.where("id in (?)", Batchstudent.find(:all, :conditions => { :student_id => current_user.employee_id}).map(&:batch_id))
        @marks = Mark.find(:all, :conditions => {:student_id => @student.id})
      elsif current_user.role.name == "Admin"
        @admin = Admin.find(current_user.employee_id)
      elsif current_user.role.name == "teacher"
        @teacher = Teacher.find(current_user.employee_id)
      end
      format.js
      format.html
    end
  end
  
  def edit
    if current_user.role.name == "student"
      @student = Student.find(params[:id])
    elsif current_user.role.name == "Admin"
      @admin = Admin.find(params[:id])
    else
      @teacher = Teacher.find(params[:id])
    end
    respond_to do |format|
      # format.html 
      format.js  # required or the controller will not respond to AJAX calls
    end
  end
  
  def update
    if current_user.role.name == "student"
      @student = Student.find(params[:id])
      respond_to do |format|
        if @student.update_attributes(params[:student])
          format.html { redirect_to @student, notice: 'Post was successfully updated.' }
          format.js {redirect_to :action => 'show_profile'}
        else
          format.js { render action: "edit" }
        end
      end
     elsif current_user.role.name == "Admin"
      @admin = Admin.find(params[:id])
      respond_to do |format|
        if @admin.update_attributes(params[:admin])
          format.html { redirect_to @admin, notice: 'Post was successfully updated.' }
          format.js {redirect_to :action => 'show_profile'}
        else
          format.js { render action: "edit" }
        end
      end
    end
    
  end
  
  def todays_test
    @student_id = Student.find(current_user.employee_id).id
    date = Date.today
    batchs = Batch.where("id in (?)", Batchstudent.find(:all, :conditions => { :student_id => current_user.employee_id}).map(&:batch_id))
    @batchtests = Batchtest.where("batch_id in(?) and start_test_date <= ? and end_test_date >= ?", batchs, date, date)

#    bhachs_id = Batch.where("start_date <= ? and end_date >= ? and id in(?)", date, date, batchs).map(&:id)
  end

  def show_profile
    respond_to do |format|
      if current_user.role.name == "student"
        @student = Student.find(current_user.employee_id)
      elsif current_user.role.name == "Admin"
        @admin = Admin.find(current_user.employee_id)
      end
      format.js 
    end
  end

  def change_password
    respond_to do |format|
      @user = current_user
      format.js
    end
  end
end
