class SessionsController < ApplicationController

  def new
    render 'login'
  end

  def create
    user = User.find_by(email: params[:email]) || nil
    if user && user.authenticate(params[:password])
      set_current_user(user)
      redirect_to user
    else
      redirect_to '/login'
    end
  end

  def destroy
    logout
  end

  def oauthcreate
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_path
  end


  private

  def logout
    session.destroy
    @current_user = nil
    redirect_to root_path
  end
end
