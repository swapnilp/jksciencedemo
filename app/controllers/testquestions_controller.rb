class TestquestionsController < ApplicationController
  load_resource
  def index
    respond_to do |format|
      @subject = Subject.find(params[:subject_id])
      @jktest = Jktest.find(params[:jktest_id])
      @testquestions = Testquestion.find(:all, :conditions => { :jktest_id => params[:jktest_id] })
      format.js
    end
  end
   
  def new
    @testquestion = Testquestion.new
    @subject_id = Subject.find(params[:subject_id]).id
    @jktest = Jktest.find(params[:jktest_id])
    testQuestions = Testquestion.where("jktest_id = #{@jktest.id}").map(&:question_id)
    topics = Topic.where("chapter_id in (?)", Chapter.where("subject_id in (?)", @subject_id))
    @questions =  (testQuestions.empty? ? Question.where("id not in (0) and topic_id in (?)", topics) : Question.where("id not in (?) and topic_id in (?)", testQuestions, topics))
    @count = @jktest.no_of_questions - Testquestion.where("jktest_id = ?", @jktest.id).count 
    respond_to do |format|
      format.js
    end
  end

  def destroy
    respond_to do |format|
      if Testquestion.find(params[:id]).destroy
        format.js { redirect_to :action => 'index', :subject_id => params[:subject_id], :jktest_id => params[:jktest_id] }
      end
    end
  end

  def add_test_questions
    respond_to do |format|
      user_id = current_user.id
      params[:questions].each do |id|
        Testquestion.new(:question_id => id.to_i, :jktest_id => params[:jktest_id], :user_id => user_id).save
      end
      format.js { redirect_to :action => 'index', :subject_id => params[:subject_id], :jktest_id => params[:jktest_id] }
    end
  end

end
