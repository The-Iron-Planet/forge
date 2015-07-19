class AddTitleAndLocationToEvents < ActiveRecord::Migration
  def change
    add_column :events, :title, :string
    add_column :events, :location, :string
    remove_column :events, :name, :string
  end
end
