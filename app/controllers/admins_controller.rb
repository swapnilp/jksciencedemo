class AdminsController < ApplicationController
  load_resource
  #for show all admin in list
  def index
    @admins = Admin.all
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @admin = Admin.find(params[:id])
  end

  def new
    @admin = Admin.new
    respond_to do |format|
      format.js  # required or the controller will not respond to AJAX calls
    end
  end

  def create
    role_id = Role.where("name='Admin'")[0][:id]
    @admin = Admin.new(params[:admin])
    respond_to do |format|
      if @admin.save
        #admin user created with jkscienceadmin password
        if User.new(:employee_id => @admin.id, :password =>'jkscienceadmin', :password_confirmation => 'jkscienceadmin', :role_id => role_id , :email => @admin.email ).save
          format.js { redirect_to :action => 'index' }
        end
      else 
        format.js { render :action => 'new'} 
      end
    end
  end

  def edit
    @admin = Admin.find(params[:id])
    respond_to do |format|
      format.js  # required or the controller will not respond to AJAX calls
    end
  end

  def update
    @admin = Admin.find(params[:id])
    respond_to do |format|
      if @admin.update_attributes(params[:admin])
        format.html { redirect_to @admin, notice: 'Post was successfully updated.' }
        format.js {redirect_to :action => 'show'}
      else
        format.js { render :action => 'edit' }
      end
    end
  end

  def destroy
    respond_to do |format|
      admin = Admin.find(params[:id])
      admin.destroy if admin.id != 1 && params[:id].to_i != current_user.employee_id
      format.js { redirect_to :action => 'index' }
    end
  end
  
end
