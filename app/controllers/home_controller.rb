class HomeController < ApplicationController
	def index
		if user_signed_in? 
			@documents = current_user.documents.order("uploaded_file_file_name desc") 
			@folders = current_user.folders.order("name desc")      
		end
	end
end
