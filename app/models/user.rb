class User < ActiveRecord::Base
  has_many :bands, :through => :memberships
  has_many :memberships
  has_secure_password
end
