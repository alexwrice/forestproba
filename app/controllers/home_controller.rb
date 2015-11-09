class HomeController < ApplicationController
	def index
		if user_signed_in? 
			#show only root folders (which have no parent folders) 
		    @clasificacions = current_user.folders.roots  

		    @folders = current_user.folders.roots  
		       
		    #show only root files which has no "folder_id" 
		    @documents = current_user.documents.where("folder_id is NULL").order("uploaded_file_file_name desc")    
		end
	end

	

	#this action is for viewing folders 
	def browse 
	    @current_folder = current_user.folders.find(params[:folder_id])  
	  	@clasificacions = current_user.folders.roots  

	  	@f = params[:f]
	  	if @f
	  		#GUARDAR NOMÉS LA ÚLTIMA CARPETA D'UN MATEIX ARBRE
	  		if current_user.folders.find(@f.last) == @current_folder.parent
	  			@f.pop
	  		end
	  		@f.push(@current_folder.id)
	  	else
	  		@f=[@current_folder.id]
	  	end



	    if @current_folder
	    
	      #getting the folders which are inside this @current_folder 
	      @folders = @current_folder.children 
	  
	      #We need to fix this to show files under a specific folder if we are viewing that folder 
	      @documents = @current_folder.documents.order("uploaded_file_file_name desc") 
	  
	      render :action => "index"
	    else
	      flash[:error] = "Don't be cheeky! Mind your own folders!"
	      redirect_to root_url 
	    end
	end
end
