class User < ActiveRecord::Base
  validates_presence_of     :identity_url
end
