class AddFileToEvent < ActiveRecord::Migration
  def change
    add_attachment :events, :uploaded_file
  end
end
