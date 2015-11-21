class Document < ActiveRecord::Base
	belongs_to :user
	has_and_belongs_to_many :folders

	#set up "uploaded_file" field as attached_file (using Paperclip) 
	has_attached_file :uploaded_file, 
						:path => "documents/:id/:basename.:extension", 
						:storage => :s3, 
						:s3_credentials => "#{::Rails.root}/config/amazon_s3.yml", 
						:bucket => "forestproba",
						:s3_host_name => 's3-eu-west-1.amazonaws.com'
	validates_attachment :uploaded_file, presence: true, size: { in: 0..10.megabytes }
	do_not_validate_attachment_file_type :uploaded_file



	def file_name 
		uploaded_file_file_name 
	end
	def file_size 
		uploaded_file_file_size 
	end
end
