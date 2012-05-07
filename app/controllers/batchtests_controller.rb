class BatchtestsController < ApplicationController
  load_resource
  def index
    respond_to do |format|
      @batch_id = params[:batch_id]
      batch = Batch.find(@batch_id)
      @batchtests = Batchtest.find(:all, :conditions => {:batch_id => @batch_id})
      format.js
    end
  end

  def new
    respond_to do |format|
      @batch_id = params[:batch_id]
      @batchtest = Batchtest.new
      @jktests = Jktest.find(:all)
      format.js
    end
  end

  def create
    @batch_id = params[:batch_id]
    @batchtest = Batchtest.new(params[:batchtest])
    @batchtest[:batch_id] = @batch_id
    
    respond_to do |format|
      if @batchtest.save
        format.js { redirect_to :action => 'index', :batch_id => params[:batch_id] }
      else
        @jktests = Jktest.find(:all)
        format.js { render :action => 'new' }
      end
    end
  end

  def edit
    respond_to do |format|
      @batch_id = params[:batch_id]
      @batchtest = Batchtest.find(params[:id])
      @jktests = Jktest.find(:all)
      format.js
    end
  end

  def update
    @batchtest = Batchtest.find(params[:id])
    respond_to do |format|
      if @batchtest.update_attributes(params[:batchtest])
        format.js { redirect_to :action => 'index', :batch_id => params[:batch_id] }
      end
    end
  end

  
  def destroy
    respond_to do |format|
      if Batchtest.find(params[:id]).destroy
        format.js { redirect_to :action => 'index', :batch_id => params[:batch_id] }
      end
    end
  end
  
  def add_batch_test
    respond_to do |format|
      @batch_id = params[:batch_id]
      params[:jktests].each do |id|
        #Batchtest.new(:batch_id => @batch_id, :jktest_id => id.to_i, :report => 'not seen').save
      end
      format.js { redirect_to :action => 'index', :batch_id => @batch_id }
    end
  end
  
end
