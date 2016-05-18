class Band < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  has_many :comments, as: :commentable
  has_many :invites
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :songs

  def membership_for(user)
    memberships.find_by(user: user)
  end

end
