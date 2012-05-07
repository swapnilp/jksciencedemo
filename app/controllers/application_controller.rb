class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!


#  def after_sign_out_path_for(resource)
#    root_path
#  end

  def after_sign_up_path_for(resource)
    if resource.is_a?(User)
      profile_path(1)
    else
      super
    end
  end
  
  
end
