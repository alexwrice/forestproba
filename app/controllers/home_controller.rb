class HomeController < ApplicationController
	def index
		if user_signed_in? 
			@documents = current_user.documents.order("uploaded_file_file_name desc")       
		end
	end
end
