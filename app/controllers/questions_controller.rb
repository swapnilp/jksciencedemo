class QuestionsController < ApplicationController
  load_resource
  def index
    respond_to do |format|
      @subject_id = params[:subject_id]
      @chapter_id = params[:chapter_id]
      @topic_id = params[:topic_id]
      @questions = Question.find(:all, :conditions => { :topic_id => @topic_id})
      format.js
    end
  end
  
  def new
    respond_to do |format|
      @subject_id= params[:subject_id]
      @chapter_id = params[:chapter_id]
      @topic_id =params[:topic_id]
      @question = Question.new
      format.js
    end
  end

  def create
    @question = Question.new(params[:question])
    @question[:user_id] = current_user.id
    @question[:topic_id] = params[:topic_id]
    respond_to do |format|
      if @question.save
        format.js {redirect_to :action => 'index' ,:subject_id => params[:subject_id], :chapter_id => params[:chapter_id], :topic_id => params[:topic_id]}
      else
        format.ja { render :action => 'new' }
      end
    end
  end
  
  def show
    respond_to do |format|
      @question = Question.find(params[:id])
      @subject_id= params[:subject_id]
      @chapter_id = params[:chapter_id]
      @topic_id =params[:topic_id]
      format.js
    end
  end

  def edit
    respond_to do |format|
      @question = Question.find(params[:id])
      @subject_id= params[:subject_id]
      @chapter_id = params[:chapter_id]
      @topic_id =params[:topic_id]
      format.js
    end
  end
  
  def update
  end

  def filter_question
    @subjects = Subject.all
  end

  def subject_questions
    respond_to do |format|
      @subjects = Subject.all
      @chapters = Chapter.find(:all, :conditions => {:subject_id => params[:subject_id]})
      @subject = Subject.find(params[:subject_id])
      chapters_id = Chapter.find(:all, :conditions => { :subject_id => params[:subject_id]}).map(&:id)
      @questions = Question.find(:all, :conditions => { :topic_id => Topic.find(:all, :conditions => { :chapter_id => chapters_id}).map(&:id) })
      format.js
    end
  end
  
  def chapter_questions
    respond_to do |format|
      @subjects = Subject.all
      @chapters = Chapter.find(:all, :conditions => { :subject_id => params[:subject_id] })
      @topics =  Topic.find(:all, :conditions => { :chapter_id => params[:chapter_id] })

      @subject = Subject.find(params[:subject_id])
      @chapter = Chapter.find(params[:chapter_id])

      @questions = Question.find(:all, :conditions => { :topic_id => Topic.find(:all, :conditions => { :chapter_id => params[:chapter_id] }).map(&:id) })
      format.js
    end
  end

  def topic_questions
    respond_to do |format|
      @subjects = Subject.all
      @chapters = Chapter.find(:all, :conditions => { :subject_id => params[:subject_id] })
      @topics =  Topic.find(:all, :conditions => { :chapter_id => params[:chapter_id] })
      @subject = Subject.find(params[:subject_id])
      @chapter = Chapter.find(params[:chapter_id])
      @topic = Topic.find(params[:topic_id])
      @questions = Question.find(:all, :conditions => { :topic_id => params[:topic_id] })
      format.js
    end
  end
end
