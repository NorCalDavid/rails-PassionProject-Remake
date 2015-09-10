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

  devise :omniauthable, :omniauth_providers => [:google_oauth2]

## User Model - Create from Oauth
###########################################

def self.from_oauth(auth)
  where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
    user.provider = auth.provider
    user.uid = auth.uid
    user.name = auth.info.name
    user.oauth_token = auth.credentials.token
    user.oauth_expires_at = Time.at(auth.credentials.expires_at)
    user.save!
  end
end

### User Model - Class Methods
###########################################

def keys
  [:name, :first_name, :last_name, :email, :cell_phone, :password]
end

def counts
  user = User.find(session[:user_id])
  return { homes: user.homes,
   rooms: user.rooms,
   devices: user.devices }
 end

end
