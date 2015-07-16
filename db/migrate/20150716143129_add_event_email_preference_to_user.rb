class AddEventEmailPreferenceToUser < ActiveRecord::Migration
  def change
    add_column :users, :get_event_email, :boolean
    add_column :users, :campus_notification_id, :integer
  end
end
