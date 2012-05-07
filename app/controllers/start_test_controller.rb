class StartTestController < ApplicationController
  layout 'start_test'
  def show
    respond_to do |format|
      @batchtest_id = params[:batchtest_id]
      @student_id = params[:student_id]
      @jktest_id = params[:jktest_id]
      last_attempt_time = Testattempt.find(:last, :conditions => { :batchtest_id => @batchtest_id, :student_id => @student_id })
      @last_attempt =  (last_attempt_time.nil? ? 130 : (Time.now - last_attempt_time.created_at).to_i / 60)
      if @last_attempt > 120
        Testattempt.new(:batchtest_id => @batchtest_id, :student_id => @student_id).save
        @testquestions = Testquestion.find(:all, :conditions => { :jktest_id => @jktest_id})      
        format.html 
      else
        format.html { render 'time_schedule'}
      end
    end
    
  end

  def result
    @marks = 0
    @batchtest_id = params[:batchtest_id]
    @jktest_id = params[:jktest_id]
    @student_id = params[:student_id]
    testquestions = Testquestion.where("jktest_id = ?", @jktest_id)
    questions = Question.where("id in (?)", testquestions.map(&:question_id))    
    
    i = 0
    question = []
    answer = []    
    @marks = 0
    if params.has_key?(:answer)
      params[:answer].each do |key, value|
        @marks += 1 if questions[questions.map(&:id).index(key.to_i)][:answer] == value
        question[i] = key
        answer[i] = value
        i +=1
      end
    end
      solvedtest = Solvedtest.new
      solvedtest[:user_id] = current_user.id
      solvedtest[:batchtest_id] = @batchtest_id
      solvedtest[:questions_id] = question.join(',')
      solvedtest[:questions_answer] = answer.join(',')
    
    solvedtest.save
    @mark = Mark.new(:student_id => @student_id, :batchtest_id => @batchtest_id, :mark => @marks)
    @mark.save
    @solvedtestquestions = Testquestion.find(:all, :conditions => { :jktest_id => @jktest_id})

    #send result email
    UserMailer.result_email(@mark).deliver
    #change the user to student_id
    solvedtest  = Solvedtest.find(:last, :conditions => {:batchtest_id => @batchtest_id, :user_id => current_user.id})
    puts solvedtest.nil?
    @solvedtest_answers = Hash[solvedtest.questions_id.split(',').map(&:to_i).zip(solvedtest.questions_answer.split(','))] if !solvedtest.nil?
    
  end
  
  def question_forum
    @topic_id  = params[:topic_id]
    respond_to do |format|
      @forum = Forum.find(:first, :conditions => { :topic_id => @topic_id })
      @posts = Post.where("forum_id = ?", @forum.id) if !@forum.nil?
      # @post = Post.new if !@forum.nil?
      format.js
    end
  end
  
  def question_forum_new_post
    respond_to do |format|
      @forum_id = params[:forum_id]
      @topic_id = params[:topic_id]
      @post = params[:post]
      @user = current_user
      if defined? params[:email]
        UserMailer.question_email(@post, @topic_id, @forum_id, @user).deliver if params[:email] == "on"
      end
      if defined? params[:add_post]
        Post.new(:post => @post, :user_id => current_user.id, :forum_id => @forum_id).save if params[:add_post] == "on"
      end
      format.js { redirect_to :action => "question_forum", :topic_id => @topic_id }
    end
  end

  def result_show
  end
  
  
end
