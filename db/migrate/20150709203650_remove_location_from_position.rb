class RemoveLocationFromPosition < ActiveRecord::Migration
  def change
    remove_column :positions, :city, :string
    remove_column :positions, :state, :string
  end
end
