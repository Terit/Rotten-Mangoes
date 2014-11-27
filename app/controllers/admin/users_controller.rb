class Admin::UsersController < ApplicationController

  before_filter :admin_access

  def index
    @users = User.all.page(params[:page]).per(5)
  end

  def edit
    @user = User.find(params[:id])
    render :'users/edit'
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id #auto login
      redirect_to movies_path, notice: "Welcome aboard, #{@user.firstname}!"
    else
      render :new
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User has been eliminated"
    redirect_to admin_users_path
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to admin_users_path
    else
      render :'users/edit'
    end
  end

  protected

  def user_params
    params.require(:user).permit(
      :email,
      :firstname,
      :lastname,
      :password,
      :password_confirmation
    )
  end
end
