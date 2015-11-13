class CreateDocumentsFoldersJoinTable < ActiveRecord::Migration
  	def change
  	  create_table :documents_folders, id: false do |t|
  	    t.integer :document_id
  	    t.integer :folder_id
  	  end
  	
  	  add_index :documents_folders, :document_id
  	  add_index :documents_folders, :folder_id
  	end
end
