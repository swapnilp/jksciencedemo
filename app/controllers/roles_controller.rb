class RolesController < ApplicationController
  load_resource
  def index
    @role = Role.all
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @role = Role.find(params[:id])
  end

  def new
    @role = Role.new
    respond_to do |format|
      format.js  # required or the controller will not respond to AJAX calls
    end
  end

  def create
    @role = Role.new(params[:role])
    respond_to do |format|
      if @role.save
        format.js { redirect_to :action => 'index' }
      else
        format.js { render :action => 'new' }
      end
    end
  end

  def edit
    @role = Role.find(params[:id])
    respond_to do |format|
      format.js  # required or the controller will not respond to AJAX calls      
    end
  end

  def update
    @role = Role.find(params[:id])
    respond_to do |format|
      if @role.update_attributes(params[:role])
        format.html { redirect_to @role, notice: 'Role was successfully updated.' }
        format.js {redirect_to :action => 'show'}
      else
        format.js {render :action => 'edit' }
      end
    end
  end

  def destroy
    respond_to do |format|
      role = Role.find(params[:id])
      role.destroy if role.name != "Admin" 
      format.js { redirect_to :action => 'index' }
    end
  end
  
end
