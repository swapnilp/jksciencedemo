class HomeController < ApplicationController
  skip_before_filter :authenticate_user!
  layout 'home'
  def index
  end
  def notification
  end
  def result
  end
  def join_us
  end
  def about
  end
end
