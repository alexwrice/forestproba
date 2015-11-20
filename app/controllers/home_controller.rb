class HomeController < ApplicationController
	def index
		if user_signed_in? 
			#show only root folders (which have no parent folders) 
			@clasificacions = current_user.folders.roots  

			# @folders = current_user.folders.roots  
			@folders = []
			@roots = []
		    #show only root files which has no "folder_id" 
		    # @documents = current_user.documents.where("folder_ids is NULL").order("uploaded_file_file_name desc")   
		    @documents = current_user.documents.order("updated_at desc")
		end
	end



	#this action is for viewing folders 
	def browse 
		@current_folder = current_user.folders.find(params[:folder_id])  
		@clasificacions = current_user.folders.roots  

		@f = params[:f]
		if @f 


				#Saltar entre arbres
				# .parent == nil vol dir que es una clasificació!!
				# @f.pop if @current_folder.parent == nil && current_user.folders.find(@f.last).parent == nil
				@f.pop if current_user.folders.find(@f.last).parent == nil

				#Torna enrere
				@f.pop(@f.length-@f.index("#{@current_folder.id}")) if @f.include?("#{@current_folder.id}")


				@f.push(@current_folder.id)
		else
				@f=[@current_folder.id]
		end


		if @current_folder

			#FILTREM RESULTATS
			#Obtenim documents i seleccionem els que toquen
			#Hem de passar les ids a numeros, son numbers
			@documents = @current_folder.documents.order("updated_at desc").select{ |d|  @f.map(&:to_i).included_in?(d.folder_ids)}

			#FILTREM CARPETES
			#Estem creuant arbres --> només apareixen carpetes on hi ha resultats
			#No estem creuant arbres --> totes les carpetes
			documents_ids = []
			@documents.each{|d| documents_ids << d.id }


			#Només filtrem carpetes si hitop_menu_clasificacions ha més d'1 arbre
			#roots => noms de les clasificacions
			@roots = []
			@f.each{|id| @roots << current_user.folders.find(id).root}
			@roots = @roots.uniq

			if @roots.length == 1
				@folders = @current_folder.children
			else
				@folders = @current_folder.children.select { |f| f.document_ids.intersects_with?(documents_ids)}
			end




			render :action => "index"
		else
			flash[:error] = "Don't be cheeky! Mind your own folders!"
			redirect_to root_url 
		end
	end
end
