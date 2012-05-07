class UserMailer < ActionMailer::Base
  default from: "swapnil.patil04@gmail.com"
  
  def welcome_email(user)
    @user = user
    @url  = "http://www.jkscience.in/users/sign_in"
    mail(:to => user.email, :subject => "Your has been created")
  end
  
  def result_email(mark)
    @mark = mark
    emails = "swapnil.patil04@gmail.com" << ", " << Teacher.where("subject_id in (?)", @mark.batchtest.jktest.subject_id).map(&:email).join(", ") << ", " << Student.find(@mark.student_id)[:email]
    @score =  (@mark.mark.to_f / Testquestion.where("jktest_id = ?", @mark.batchtest.jktest_id).count)* 100
    mail(:to => emails, :subject => "#{@mark.batchtest.jktest.name} solved by #{@mark.student.name}")
  end
  
  def question_email(post, topic_id, forum_id, user)
    @post = post
    @topic = Topic.find(topic_id)
    @forum = Forum.find(forum_id)[:title]
    emails = Teacher.where("subject_id in (?)", @topic.chapter.subject_id).map(&:email).join(", ")
    mail(:to => emails, :subject => "#{Student.find(user.employee_id)[:name]} ask question on #{@topic.name}")
  end

  def forum_email
  end
  
  def report_email
  end
end
