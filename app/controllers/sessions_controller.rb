class SessionsController < ApplicationController
  
  def new
  end

  def create
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      create_session(user)
      redirect_to root_path
    else
      flash[:error] = 'Invalid credentials'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end