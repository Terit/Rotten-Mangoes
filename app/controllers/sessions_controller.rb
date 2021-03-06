class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      session[:admin_id] = user.id if user.role == 'admin'
      redirect_to movies_path, flash: { info: "Welcome back, #{user.firstname}!" }
    else
      flash.now[:alert] = "Log in failed..."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to movies_path, flash: { info: "Adios!" }
  end
end
