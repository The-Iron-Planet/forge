class AddWebsiteHtmlToUsersJobPostsEvents < ActiveRecord::Migration
  def change
    add_column :users, :website_html, :string
    add_column :job_posts, :website_html, :string
    add_column :events, :website_html, :string
  end
end
