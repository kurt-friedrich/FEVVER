class Song < ActiveRecord::Base
  belongs_to :band
  has_many :attachments
  has_many :comments, as: :commentable
end
