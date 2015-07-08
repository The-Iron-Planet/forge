class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.date :started_on
      t.date :ended_on
      t.integer :campus_id
      t.integer :curriculum_id
      t.integer :cohort

      t.timestamps null: false
    end
  end
end
