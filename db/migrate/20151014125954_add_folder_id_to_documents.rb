class AddFolderIdToDocuments < ActiveRecord::Migration
  # def change
  #   add_column :documents, :folder_id, :integer
  #   add_index :documents, :folder_id
  # end
  
  # def self.down 
  #   remove_column :documents, :folder_id
  # end
 def change
 	remove_column :documents, :folder_id
 end
end
