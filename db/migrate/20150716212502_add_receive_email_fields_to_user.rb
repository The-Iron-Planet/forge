class AddReceiveEmailFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :get_job_email, :boolean
    add_column :users, :get_resource_email, :boolean
  end
end
