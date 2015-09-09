class Home < ActiveRecord::Base

  has_many :properties
  has_many :users, through: :properties, dependent: :destroy
  has_many :rooms

  validates :name, :presence => true
  validates :address, :presence => true
  validates :city, :presence => true
  validates :state, :presence => true
  validates :zip_code, :presence => true

  def keys
    [:name, :description, :address, :city, :state, :zip_code]
  end

end
