class Attachment < ActiveRecord::Base
  attachment :file, extension: ["mp3", "m4a"]
  belongs_to :song
end
