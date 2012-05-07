class PasswordsController < ApplicationController
  before_filter :authenticate_user!

  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    # raise params.inspect
    puts @user
    if @user.update_with_password(params[:user])
      sign_in(@user, :bypass => true)
      redirect_to profile_path(1), :notice => "Your Password has been updated!"
    else
      render :edit,:locals => { :resource => @user, :resource_name => "user" }
    end
  end
  
end
