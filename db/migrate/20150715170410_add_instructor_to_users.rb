class AddInstructorToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_instructor, :boolean
  end
end
