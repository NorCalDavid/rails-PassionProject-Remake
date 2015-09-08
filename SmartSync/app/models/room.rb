class Room < ActiveRecord::Base
  belongs_to :home
  has_many :devices

  def keys
    [:name, :description]
  end
end
