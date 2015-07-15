class AddActiveToJobPosts < ActiveRecord::Migration
  def change
    add_column :job_posts, :active, :boolean
  end
end
