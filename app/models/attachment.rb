class Attachment < ActiveRecord::Base
  attachment :file
  belongs_to :song
end
