class SessionsController < ApplicationController
  def new
    render 'login'
  end

  def create

  end

  def destroy
    logout
  end

  private

  def set_current_user

  end

  def logout
    session.destroy
    @current_user = nil
    redirect root
  end
end
