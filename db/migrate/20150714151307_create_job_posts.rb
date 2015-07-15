class CreateJobPosts < ActiveRecord::Migration
  def change
    create_table :job_posts do |t|
      t.integer :company_id
      t.integer :user_id
      t.integer :curriculum_id
      t.string :title
      t.text :description
      t.string :experience_desired
      t.string :website
      t.date :expires_on

      t.timestamps null: false
    end
  end
end
