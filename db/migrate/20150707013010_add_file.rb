class AddFile < ActiveRecord::Migration
  def change
    add_attachment :users, :uploaded_file
  end
end
