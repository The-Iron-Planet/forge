class AddWebsiteHtmlToResources < ActiveRecord::Migration
  def change
    add_column :resources, :website_html, :string
  end
end
