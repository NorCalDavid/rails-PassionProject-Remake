class Property < ActiveRecord::Base
  belongs_to :user
  belongs_to :home
end
