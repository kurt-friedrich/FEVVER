class Band < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  has_many :comments, as: :commentable
  has_many :invites
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :songs
  before_validation :downcase_name
  validates :name, presence: true
  validates :name, uniqueness: true

  def membership_for(user)
    memberships.find_by(user: user)
  end

  def downcase_name
    name.downcase!
  end
end
