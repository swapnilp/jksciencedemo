class SubjectsController < ApplicationController
  load_resource
  def index
    @subjects = Subject.all
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def new
    @subject = Subject.new
    respond_to do |format|
      format.js  # required or the controller will not respond to AJAX calls
    end
  end

  def create
    @subject = Subject.new(params[:subject])
    @subject[:user_id] = current_user.id
    respond_to do |format|
      if @subject.save
        format.js { redirect_to :action => 'index' }
      else
        format.js { render :action => 'new' }
      end
    end
  end

  def edit
    @subject = Subject.find(params[:id])
    respond_to do |format|
      format.js  # required or the controller will not respond to AJAX calls
    end
  end
  
  def update
    @subject = Subject.find(params[:id])
    respond_to do |format|
      if @subject.update_attributes(params[:subject])
        format.html { redirect_to @subject, notice: 'Post was successfully updated.' }
        format.js {redirect_to :action => 'index'}
      else
        format.js { render :action => 'edit' }
      end
    end
  end

  def destroy
    respond_to do |format|
      if Subject.find(params[:id]).destroy
        format.js { redirect_to :action => 'index' }
      end
    end
  end
end
