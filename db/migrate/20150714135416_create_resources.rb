class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :title
      t.text :description
      t.string :website
      t.integer :user_id
      t.integer :curriculum_id

      t.timestamps null: false
    end
  end
end
