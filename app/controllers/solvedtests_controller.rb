class SolvedtestsController < ApplicationController
  load_resource
  def index
    @solved_tests = Solvedtest.paginate(:page => params[:page])
  end

  def show
    @solved_test = Solvedtest.find(params[:id])
  end

  def new
    @solved_test = Solvedtest.new
  end

  def create
    if @solved_test.save!
      redirect_to :action => "index"
    else
      flash.now[:error] = "Could not solved test"
      render :action => "new"
    end
  end
 
  def edit
    @solved_test = Solvedtest.find(params[:id])
  end
  
  def update
    if @solved_test.update_attribute(:name, params[:name])
      redirect_to :action => 'show', :id => @solved_test
    else
      @solved_tests = Solvedtest.find(:all)
      render :action => 'edit'
    end
  end
  
  def destroy
    Solvedtest.find(params[:id]).destroy
    redirect_to :action => 'index'
  end
end
