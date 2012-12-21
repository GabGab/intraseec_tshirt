class User < ActiveRecord::Base
  attr_accessible :email, :expire, :first_name, :last_name, :token, :uid

  validates_presence_of :uid
end
