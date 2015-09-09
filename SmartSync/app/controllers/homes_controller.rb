class HomesController < ApplicationController

  def index
    @homes = User.find(session[:user_id]).homes
  end

  def new
    @home = Home.new
  end

  def create
    home = Home.new(home_params)
    if home.save
      User.find(session[:user_id]).properties.create!(home: home)
      redirect_to home
    else
      render 'new'
    end

  end

  def show
    @home = Home.find(params[:id])
  end

  def edit
    @home = Home.find(params[:id])
  end

  def update
     home = Home.find(params[:id])

    if home.update(home_params)
      redirect_to home
    else
      render 'edit'
    end
  end

  def destroy
    home = Home.find(params[:id])
    if home.destroy
      redirect_to user_path
    else
      false
      status 417
    end

  end

private

  def home_params
    params.require(:home).permit(:name, :description, :address, :city, :state, :zip_code)
  end

end
