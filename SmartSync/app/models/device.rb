class Device < ActiveRecord::Base
  belongs_to :room
  has_one :home, through: :room
  has_many :user_devices
  has_many :users, through: :user_devices

  def keys
    [:name, :description, :status, :code]
  end
end
