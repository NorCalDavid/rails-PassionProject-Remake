class RoomsController < ApplicationController

  def index
    @home = Home.find(params[:home_id])
    @rooms = Home.find(params[:home_id]).rooms
  end

  def new
    @room = Room.new
  end

  def create
    room = Home.find(params[:home_id]).rooms.new(room_params)
    if room.save
      # Home.find(params[:home_id]).rooms.create!(room: room)
      redirect_to home_rooms_path
    else
      render 'new'
    end

  end

  def show
    @room = Room.find(params[:id])
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
     room = Room.find(params[:id])

    if room.update(room_params)
      redirect_to home_room_path
    else
      render 'edit'
    end
  end

  def destroy
    room = Room.find(params[:id])
    if room.destroy
      redirect_to user_path
    else
      false
      status 417
    end

  end

private

  def room_params
    params.require(:room).permit(:name, :description)
  end

end
