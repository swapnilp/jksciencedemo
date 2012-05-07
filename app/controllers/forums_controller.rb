class ForumsController < ApplicationController
  def index
    respond_to do |format|
      @subject_id = params[:subject_id]
      @chapter_id = params[:chapter_id]
      @topic_id = params[:topic_id]
      @forums = Forum.find(:all, :conditions => { :topic_id => @topic_id})
      format.js
    end
  end
  
  def new
    respond_to do |format|
      @subject_id= params[:subject_id]
      @chapter_id = params[:chapter_id]
      @topic_id =params[:topic_id]
      @forum = Forum.new
      format.js
    end
  end

  def create
    @forum = Forum.new(params[:forum])
    @forum[:user_id] = current_user.id
    @forum[:topic_id] = params[:topic_id]
    respond_to do |format|
      if @forum.save
        format.js {redirect_to :action => 'topic_forums' ,:subject_id => params[:subject_id], :chapter_id => params[:chapter_id], :topic_id => params[:topic_id]}
      end
    end
  end
  
  def show
    respond_to do |format|
      @forum = Forum.find(params[:id])
      @subject_id= params[:subject_id]
      @chapter_id = params[:chapter_id]
      @topic_id =params[:topic_id]
      format.js
    end
  end

  def edit
    respond_to do |format|
      @forum = Forum.find(params[:id])
      @subject_id= params[:subject_id]
      @chapter_id = params[:chapter_id]
      @topic_id =params[:topic_id]
      format.js
    end
  end
  
  def update
    @subject_id= params[:subject_id]
    @chapter_id = params[:chapter_id]
    @topic_id =params[:topic_id]
    @forum = Forum.find(params[:id])
    respond_to do |format|
      if @forum.update_attributes(params[:forum])
        format.html { redirect_to @student, notice: 'Post was successfully updated.' }
        format.js {redirect_to :action => 'show'}
      else
        format.js { render action: "edit" }
      end
    end
  end

  def filter_forum
    @subjects = Subject.all
  end

  def subject_forums
    respond_to do |format|
      @subjects = Subject.all
      @chapters = Chapter.find(:all, :conditions => {:subject_id => params[:subject_id]})
      @subject = Subject.find(params[:subject_id])
      chapters_id = Chapter.find(:all, :conditions => { :subject_id => params[:subject_id]}).map(&:id)
      @forums = Forum.find(:all, :conditions => { :topic_id => Topic.find(:all, :conditions => { :chapter_id => chapters_id}).map(&:id) })
      format.js
    end
  end
  
  def chapter_forums
    respond_to do |format|
      @subjects = Subject.all
      @chapters = Chapter.find(:all, :conditions => { :subject_id => params[:subject_id] })
      @topics =  Topic.find(:all, :conditions => { :chapter_id => params[:chapter_id] })

      @subject = Subject.find(params[:subject_id])
      @chapter = Chapter.find(params[:chapter_id])

      @forums = Forum.find(:all, :conditions => { :topic_id => Topic.find(:all, :conditions => { :chapter_id => params[:chapter_id] }).map(&:id) })
      format.js
    end
  end

  def topic_forums
    respond_to do |format|
      @subjects = Subject.all
      @chapters = Chapter.find(:all, :conditions => { :subject_id => params[:subject_id] })
      @topics =  Topic.find(:all, :conditions => { :chapter_id => params[:chapter_id] })
      @subject = Subject.find(params[:subject_id])
      @chapter = Chapter.find(params[:chapter_id])
      @topic = Topic.find(params[:topic_id])
      @forums = Forum.find(:all, :conditions => { :topic_id => params[:topic_id] })
      format.js
    end
  end
end
