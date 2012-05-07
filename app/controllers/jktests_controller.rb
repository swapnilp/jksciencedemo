class JktestsController < ApplicationController
  load_resource
  def index
    @subject = Subject.find(params[:subject_id])
    @jktests = Jktest.find(:all, :conditions => { :subject_id => @subject.id })
  end
  
  def new
    respond_to do |format|
      @jktest = Jktest.new
      @subject_id = params[:subject_id]
      format.js
    end
  end

  def edit
    @jktest = Jktest.find(params[:id])
    @subject_id = params[:subject_id]
    respond_to do |format|
      format.js
    end
  end
  
  def create
    @jktest = Jktest.new(params[:jktest])
    @jktest[:user_id] = current_user.id
    @jktest[:subject_id] = params[:subject_id]
    respond_to do |format|
      if @jktest.save
        format.js { redirect_to :action => 'index', :subject_id => params[:subject_id] }
      else
        format.js { render :action => 'new' }
      end
    end
  end

  def update
    @jktest = Jktest.find(params[:id])
    respond_to do |format|
      if @jktest.update_attributes(params[:jktest])
        format.js { redirect_to :action => 'index', :subject_id => params[:subject_id] }
      else
        format.js { render :action => 'edit' }
      end
    end
  end
  
  def destroy
    respond_to do |format|
      Jktest.find(params[:id]).destroy
      format.js {redirect_to :action => 'index', :subject_id => params[:subject_id]}
    end
  end
  
  def select_subject
    @subjects = Subject.all
  end

end
