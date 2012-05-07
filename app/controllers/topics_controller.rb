class TopicsController < ApplicationController
  load_resource
  def index
    respond_to do |format|
      @topics = Topic.find(:all, :conditions => {:chapter_id => params[:chapter_id]})
      @chapter_id = params[:chapter_id]
      @subject_id = params[:subject_id]
      #render :partial => 'index'
      format.js  # required or the controller will not respond to AJAX calls
    end
  end
  
  def new
    respond_to do |format|
      @topic = Topic.new
      @chapter_id = params[:chapter_id]
      @subject_id = params[:subject_id]
      format.js
    end
  end
  
  def create
    @topic = Topic.new(params[:topic])
    @topic[:user_id] = current_user.id
    @topic[:chapter_id] = params[:chapter_id]
    respond_to do |format|
      if @topic.save
        format.js { redirect_to :action => 'index' }
      end
    end
  end
  
  def show
  end
  
  def edit
    respond_to do |format|
      @topic = Topic.find(params[:id])
      @subject_id = params[:subject_id]
      @chapter_id = params[:chapter_id]
      format.js
    end
  end
  
  def update
    @topic = Topic.find(params[:id])
    respond_to do |format|
      if @topic.update_attributes(params[:topic])
        format.html { redirect_to @topics, notice: 'topic was successfully updated.' }
        format.js {redirect_to :action => 'index'}
      else
        format.html { render action: "edit" }
        format.js
      end
    end
  end
  
  def destroy
    respond_to do |format|
      if Topic.find(params[:id]).destroy
        format.js { redirect_to :action => 'index' }
      end
    end
  end
end
