class Song < ActiveRecord::Base
  belongs_to :band
  has_many :attachments, dependent: :destroy
  has_many :comments, as: :commentable
  accepts_nested_attributes_for :attachments
  validates :name, :lyrics, :key, presence: true
end
