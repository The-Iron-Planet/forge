class UpdateUserAndCourseTable < ActiveRecord::Migration
  def change
    add_column :users, :curriculum_id, :integer
    remove_column :courses, :cohort, :integer
  end
end
