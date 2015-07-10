class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :happens_on
      t.text :description
      t.string :website
      t.integer :campus_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
