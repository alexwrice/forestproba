class AddFolderIdToDocuments < ActiveRecord::Migration
  def self.up 
    add_column :documents, :folder_id, :integer
    add_index :documents, :folder_id
  end
  
  def self.down 
    remove_column :documents, :folder_id
  end
end
