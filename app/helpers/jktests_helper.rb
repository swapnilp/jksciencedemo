module JktestsHelper
  def check_test_question(jktest_id)
    Batchtest.find(:all, :conditions => { :jktest_id => jktest_id} ).count < Jktest.find(jktest_id).no_of_questions ? true : false
  end
end
