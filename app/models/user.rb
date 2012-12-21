class User < ActiveRecord::Base
  attr_accessible :email, :expire, :first_name, :last_name, :token, :uid

  new_user = Proc.new { |user| user.is_from_user_form }

  attr_accessor :is_from_user_form
  attr_accessible :is_from_user_form

  validates_presence_of :uid
  validates_presence_of :email, :first_name, :last_name, :if => new_user
end
