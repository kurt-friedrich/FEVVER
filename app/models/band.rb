class Band < ActiveRecord::Base
  #belongs_to :owner, class_name: ‘User’
  has_many :comments, as: :commentable
  has_many :memberships
  has_many :users, through: :memberships
  has_many :songs

  def set_owner
  end
end
