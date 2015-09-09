class DevicesController < ApplicationController

  def index
    @home = Home.find(params[:home_id])
    @room = Room.find(params[:room_id])
    @devices = Room.find(params[:room_id]).devices
  end

  def new
    @device = Device.new
  end

  def create
    device = Room.find(params[:room_id]).devices.new(device_params)
    if device.save
      current_user.devices << device
      redirect_to home_room_devices_path
    else
      render 'new'
    end

  end

  def show
    @device = Device.find(params[:id])
  end

  def edit
    @device = Device.find(params[:id])
  end

  def update
     device = Device.find(params[:id])

    if device.update(device_params)
      redirect_to home_room_device_path
    else
      render 'edit'
    end
  end

  def destroy
    device = Device.find(params[:id])
    if device.destroy
      redirect_to user_path
    else
      false
      status 417
    end

  end

private

  def device_params
    params.require(:device).permit(:name, :description, :code, :status)
  end

end
