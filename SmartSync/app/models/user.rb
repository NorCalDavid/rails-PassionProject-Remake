class User < ActiveRecord::Base

  has_secure_password
  has_many :properties
  has_many :homes, through: :properties, dependent: :destroy
  has_many :rooms, through: :homes, source: :properties

  has_many :user_devices
  has_many :devices, through: :user_devices

  validates :email, {
                      :uniqueness => {:case_sensitive => false},
                      :format => {:with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}
                    }

  validates :password, :presence => true, length: {minimum: 6}, confirmation: true

### User Model - Class Methods
###########################################

  def keys
    [:name, :first_name, :last_name, :email, :cell_phone, :password]
  end

end
