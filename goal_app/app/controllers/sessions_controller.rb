class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_credentials(params[:user][:username],params[:user][:password])
    if user
      login(user)
      redirect_to user_url(user)
    else
      flash.now[:errors] = ['Wrong username or password idiot']
      render :new
    end
  end

  def destroy
    log_out
    redirect_to users_url
  end

end