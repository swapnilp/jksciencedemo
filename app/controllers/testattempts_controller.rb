class TestattemptsController < ApplicationController
  load_resource  
  def index
    @batch_id = params[:batch_id]
    @batchtest_id = params[:batchtest_id]
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @batch_id = params[:batch_id]
    @batchtest_id = params[:batchtest_id]
    respond_to do |format|
      Testattempt.find(params[:id]).destroy
      format.js { redirect_to :action => 'index' }
    end
  end

end
