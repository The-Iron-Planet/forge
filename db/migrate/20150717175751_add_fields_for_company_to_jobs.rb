class AddFieldsForCompanyToJobs < ActiveRecord::Migration
  def change
    tables = [:job_posts, :positions]

    tables.each do |table_name|
      add_column table_name, :company_name, :string
      add_column table_name, :location, :string
      remove_column table_name, :company_id, :integer
    end
  end
end
