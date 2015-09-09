class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)

    if user.save
      set_current_user(user)
      redirect_to user
    else
      render 'new'
    end

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end

  end

  def show
    @user = User.find(params[:id])
  end

  def homes
    @homes = User.find(params[:id]).homes
  end

  def rooms
    @homes = User.find(session[:user_id]).homes
  end

  def devices
    @homes = User.find(session[:user_id]).homes
  end

  private

  def user_params
    params.require(:user).permit(:name, :first_name, :last_name, :email, :password, :password_confirmation)
  end

   def set_current_user(user)
    session[:user_id] = user.id
    @current_user = user
  end

end
