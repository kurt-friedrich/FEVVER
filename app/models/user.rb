class User < ActiveRecord::Base
  has_secure_password
  has_many :bands, :through => :memberships
  has_many :memberships
  has_many :invitations, class_name: 'Invite', foreign_key: 'recipient_id'
  has_many :sent_invites, class_name: 'Invite', foreign_key: 'sender_id'

  before_validation :downcase_email
  validates :email, :username, presence: true
  validates :email, uniqueness: true
  validates :password, length: {
    minimum: 8,
    too_short: "password must be between 8 and 25 characters",
    maximum: 25,
    too_long: "password must be between 8 and 25 characters"
  }, on: :create
  validates :password, length: {
    minimum: 8,
    too_short: "password must be between 8 and 25 characters",
    maximum: 25,
    too_long: "password must be between 8 and 25 characters"
  }, on: :update, allow_nil: true
  validate :email_is_valid_format

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  def has_bands?
    bands.count > 0
  end

  def is_owner?(band)
    self == band.owner
  end

  def order_bands
    owner = []
    member = []
    bands.each do |band|
      if is_owner?(band)
        owner << band
      else
        member << band
      end
    end
    ordered_bands = owner + member
    ordered_bands
  end

  private

  def downcase_email
    email.downcase! if email
  end

  def email_is_valid_format
    errors.add(:email, "not a valid email address") unless self.email =~ VALID_EMAIL_REGEX
  end
end
