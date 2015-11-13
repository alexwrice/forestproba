class HomeController < ApplicationController
	def index
		if user_signed_in? 
			#show only root folders (which have no parent folders) 
			@clasificacions = current_user.folders.roots  

			# @folders = current_user.folders.roots  
			@folders = []

		    #show only root files which has no "folder_id" 
		    # @documents = current_user.documents.where("folder_ids is NULL").order("uploaded_file_file_name desc")   
		    @documents = current_user.documents 
		end
	end

	

	#this action is for viewing folders 
	def browse 
		@current_folder = current_user.folders.find(params[:folder_id])  
		@clasificacions = current_user.folders.roots  

		@f = params[:f]
		if @f
			 # Passem de strings a integers
	  		# #GUARDAR NOMÉS LA ÚLTIMA CARPETA D'UN MATEIX ARBRE
	  		# if current_user.folders.find(@f.last) == @current_folder.parent
	  		# 	@f.pop
	  		# end

	  		#no funciona quan canvia d'arbre

	  		#Torna enrere
	  		if @f.include?("#{@current_folder.id}")
	  			@f.pop(@f.length-@f.index("#{@current_folder.id}")) 
	  		end
	  		@f.push(@current_folder.id)
	  	else
	  		@f=[@current_folder.id]
	  	end


	  	if @current_folder

	      #getting the folders which are inside this @current_folder 
	      @folders = @current_folder.children 


	      #FILTREM RESULTATS
	      #Obtenim documents i seleccionem els que toquen
	      #Hem de passar les ids a numeros, son numbers
	      @documents = @current_folder.documents.order("uploaded_file_file_name desc").select{ |d|  @f.map(&:to_i).included_in?(d.folder_ids)}


	      render :action => "index"
		else
		  flash[:error] = "Don't be cheeky! Mind your own folders!"
		  redirect_to root_url 
		end
	end
end
