class Document < ActiveRecord::Base
	belongs_to :user

	#set up "uploaded_file" field as attached_file (using Paperclip) 
	has_attached_file :uploaded_file #, :url => "/documents/get/:id", :path => ":Rails_root/documents/:id/:basename.:extension"
	
	validates_attachment :uploaded_file, presence: true,
	content_type: { content_type: "image/jpeg" },
	size: { in: 0..10.megabytes }
end
