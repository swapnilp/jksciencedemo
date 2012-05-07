class ChaptersController < ApplicationController
  load_resource
  def index
    respond_to do |format|
      @chapters = Chapter.find(:all, :conditions => {:subject_id => params[:subject_id]})
      @subject_id = params[:subject_id]
      #render :partial => 'index'
      format.js  # required or the controller will not respond to AJAX calls
    end
  end
  
  def new
    respond_to do |format|
      @chapter = Chapter.new
      @subject_id = params[:subject_id]
      format.js
    end
  end
  
  def create
    @chapter = Chapter.new(params[:chapter])
    @chapter[:subject_id] = params[:subject_id]
    @subject_id = params[:subject_id]
    respond_to do |format|
      if @chapter.save
        format.js { redirect_to :action => 'index' }
      else
        format.js { render :action => 'new' }
      end
    end
  end
  
  def show
    respond_to do |format|
      @chapter = Chapter.find(params[:id])
      @subject_id = params[:subject_id]
      format.js
    end
  end
  
  def edit
    respond_to do |format|
      @chapter = Chapter.find(params[:id])
      @subject_id = params[:subject_id]
      format.js
    end
  end
  
  def update
    @chapter = Chapter.find(params[:id])
    respond_to do |format|
      if @chapter.update_attributes(params[:chapter])
        format.html { redirect_to @student, notice: 'Chapter was successfully updated.' }
        format.js {redirect_to :action => 'index'}
      else
        format.html { render action: "edit" }
        format.js
      end
    end
  end
  
  def destroy
    respond_to do |format|
      if Chapter.find(params[:id]).destroy
        format.js { redirect_to :action => 'index' }
      end
    end
  end
end
