class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_mentor, :boolean
    add_column :users, :twitter, :string
    add_column :users, :slack_handle, :string
    add_column :users, :linked_in, :string
  end
end
