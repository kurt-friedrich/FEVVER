class User < ActiveRecord::Base
  has_many :bands, :through => :memberships
  has_many :memberships
end
