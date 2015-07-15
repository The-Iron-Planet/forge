class RemoveUploadedFileFromResources < ActiveRecord::Migration
  def change
    remove_attachment :resources, :uploaded_file
  end
end
