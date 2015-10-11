class AddAttachmentUploadedFileToDocuments < ActiveRecord::Migration
  def self.up
    change_table :documents do |t|
      t.attachment :uploaded_file
    end
  end

  def self.down
    remove_attachment :documents, :uploaded_file
  end
end
