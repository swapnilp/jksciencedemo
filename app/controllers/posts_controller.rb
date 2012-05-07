class PostsController < ApplicationController
  load_resource
  def index
    respond_to do |format|
      @subject_id = params[:subject_id]
      @chapter_id = params[:chapter_id]
      @topic_id = params[:topic_id]
      @forum_id = params[:forum_id]
      @posts = Post.find(:all, :conditions => { :forum_id => params[:forum_id]})
      format.js
    end
  end
  
  def new
    @subject_id = params[:subject_id]
    @chapter_id = params[:chapter_id]
    @topic_id = params[:topic_id]
    @forum_id = params[:forum_id]
    @post = Post.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @subject_id = params[:subject_id]
    @chapter_id = params[:chapter_id]
    @topic_id = params[:topic_id]
    @forum_id = params[:forum_id]

    @post = Post.new(params[:post])
    @post[:user_id] = current_user.id
    @post[:forum_id] = @forum_id
    respond_to do |format|
      if @post.save
        format.js {redirect_to :action => 'index', :subject_id => @subject_id, :chapter_id => @chapter_id, :topic_id => @topic_id, :forum_id => @forum_id }
      end
    end
  end
  
  def update
  end

  def destroy
    @subject_id = params[:subject_id]
    @chapter_id = params[:chapter_id]
    @topic_id = params[:topic_id]
    @forum_id = params[:forum_id]
    
    Post.find(params[:id]).destroy
    respond_to do |format|
      format.js {redirect_to :action => 'index', :subject_id => @subject_id, :chapter_id => @chapter_id, :topic_id => @topic_id, :forum_id => @forum_id }
    end
  end
end
