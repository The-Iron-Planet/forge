class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.integer :user_id
      t.integer :company_id
      t.string :city
      t.string :state
      t.string :title
      t.string :description
      t.date :started_on
      t.date :ended_on
      t.boolean :current

      t.timestamps null: false
    end
  end
end
