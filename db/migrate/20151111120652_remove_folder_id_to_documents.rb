class RemoveFolderIdToDocuments < ActiveRecord::Migration
  def change
  	remove_column :documents, :folder_id
  end
end
