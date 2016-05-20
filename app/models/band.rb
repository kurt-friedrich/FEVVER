class Band < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  has_many :comments, as: :commentable
  has_many :invites
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :songs
  validates :name, presence: true
  validates :name, uniqueness: true

  def has_songs?
    songs.count > 0
  end

  def membership_for(user)
    memberships.find_by(user: user)
  end

  def order_users
    band_owner = []
    band_members = []
    users.each do |user|
      if user == owner
        band_owner << user
      else
        band_members << user
      end
    end
    ordered = band_owner + band_members
    ordered
  end

  private

  def downcase_name
    name.downcase!
  end
end
