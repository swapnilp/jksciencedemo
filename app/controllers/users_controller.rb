class UsersController < ApplicationController
  load_resource
  def index
    respond_to do |format|
      @users = User.where("role_id != 1")
      format.js
    end
  end
  
  def new
    respond_to do |format|
      users = User.where("role_id = ?", Role.find(:first, :conditions => { :name => 'student'})).map(&:employee_id)
      @students =  (users != [] ? Student.where("id not in (?)", users) : Student.all)
      @user = User.new
      format.js
    end
  end
  
  def show
    respond_to do |format|
    end
  end

  def create
    role_id = Role.where("name='student'")[0][:id]
    email = Student.first(:select => :email ,:conditions =>{:id => params[:user][:employee_id]})[:email]
    @user = User.new(:employee_id => params[:user][:employee_id], :password =>'jkscience123', :password_confirmation => 'jkscience123', :role_id => role_id, :email => email )
    respond_to do |format|
      if @user.save
        UserMailer.welcome_email(@user).deliver
        format.js {redirect_to :action => 'index'}
      else
        users = User.where("role_id = ?", Role.find(:first, :conditions => { :name => 'student'})).map(&:id)
        @students =  (users != [] ? Student.where("id not in (?)", users) : Student.all)
        format.js {render :action => 'new' }
      end
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    respond_to do |format|
      format.js {redirect_to :action => 'index'}
    end
  end
end
